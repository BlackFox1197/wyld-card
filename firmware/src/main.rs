use bluedroid::gatt_server::Profile;
use bluedroid::gatt_server::Service;
use bluedroid::gatt_server::GLOBAL_GATT_SERVER;
use bluedroid::gatt_server::Characteristic;
use bluedroid::utilities::BleUuid;
use bluedroid::utilities::AttributePermissions;
use bluedroid::utilities::CharacteristicProperties;
use bluedroid::utilities::Appearance;

use esp_idf_sys as _; // If using the `binstart` feature of `esp-idf-sys`, always keep this module imported

use std::time::Duration;

use embedded_graphics::{
    image::{Image, ImageRawLE},
    pixelcolor::BinaryColor,
    prelude::*,
};
use esp_idf_hal::{
    gpio::*,
    i2c::{I2cConfig, I2cDriver},
    peripherals::Peripherals,
    spi::*,
    units::FromValueType,
};
use pn532::{
    i2c::I2CInterface,
    requests::{Command, MifareCommand},
    Pn532, Request,
};
use sh1106::{prelude::*, Builder};

// Display pin configuration (SH1106-based 1.3" OLED LCD)
// gnd GND
// vcc V5
// clk 14
// mosi/sdo 13
// res 19
// dc 16
// cs 15

// NFC module pin configuration (PN532 module)
// gnd GND
// vcc 3V3
// sda 21
// scl 22

// DIP switch config (i2c) for PN532
// 1   # ON
// 2 #   KE

fn main() -> anyhow::Result<()> {
    esp_idf_svc::log::EspLogger::initialize_default();

    let peripherals = Peripherals::take().unwrap();
    let spi = peripherals.spi2;

    let dc = PinDriver::output(peripherals.pins.gpio16).unwrap();
    let sclk = peripherals.pins.gpio14;
    let sdo = peripherals.pins.gpio13; // -> MOSI

    let cs = peripherals.pins.gpio15;
    let cs_driver = PinDriver::output(cs).unwrap();

    let res = peripherals.pins.gpio19;
    let mut res = PinDriver::output(res).unwrap();
    res.set_high().unwrap();

    let config = config::Config::new()
        .baudrate(400.kHz().into())
        .write_only(true)
        .data_mode(embedded_hal::spi::MODE_0);
    let spi = SpiDeviceDriver::new_single(
        spi,
        sclk,
        sdo,
        None::<Gpio12>, // sdi/MISO; not needed
        Dma::Disabled,
        None::<Gpio15>, // cs; handled by sh1106 driver
        &config,
    )?;

    let mut disp: GraphicsMode<_> = Builder::new().connect_spi(spi, dc, cs_driver).into();

    disp.init().unwrap();
    disp.flush().unwrap();

    // let style = MonoTextStyle::new(&FONT_6X10, BinaryColor::On);
    // // Create a text at position (20, 30) and draw it using the previously defined style
    // Text::new("Hello Rust??????", Point::new(20, 30), style)
    //     .draw(&mut disp)
    //     .unwrap();

    let im: ImageRawLE<BinaryColor> = ImageRawLE::new(include_bytes!("./rust.raw"), 64);

    Image::new(&im, Point::new(32, 0)).draw(&mut disp).unwrap();

    disp.flush().unwrap();

    // FIXME: Proper reset and init sequence; sometimes contacting PN532 (see below) fails and
    //        VCC/GND need to be reconnected to get out of the loop

    // let reset = peripherals.pins.gpio32;
    // let mut reset_driver = PinDriver::output(reset).unwrap();

    // let req = peripherals.pins.gpio33;
    // let mut req_driver = PinDriver::output(req).unwrap();

    // reset_driver.set_high()?;
    // std::thread::sleep_ms(100);
    // reset_driver.set_low()?;
    // std::thread::sleep_ms(500);
    // reset_driver.set_high()?;
    // std::thread::sleep_ms(100);

    // req_driver.set_high()?;
    // std::thread::sleep_ms(100);
    // req_driver.set_low()?;
    // std::thread::sleep_ms(500);
    // req_driver.set_high()?;
    // std::thread::sleep_ms(100);

    // let i2c = peripherals.i2c0;
    // let sda = peripherals.pins.gpio21;
    // let scl = peripherals.pins.gpio22;

    // let config = I2cConfig::new().baudrate(10.kHz().into());
    // let i2c = I2cDriver::new(i2c, sda, scl, &config)?;
    // let interface = I2CInterface { i2c };
    // let mut pn532: Pn532<_, 128> = Pn532::new(interface);

    // println!("Trying to contact PN532...");
    // loop {
    //     match pn532.process(&Request::GET_FIRMWARE_VERSION, 4) {
    //         Ok(ver) => {
    //             println!("Firmware ver: {:x?}", ver);
    //             break;
    //         }
    //         Err(e) => println!("{:?}", e),
    //     }
    // }
    // pn532.process(&Request::GET_FIRMWARE_VERSION, 4).unwrap();

    // // Configure PN532
    // pn532
    //     .process(&Request::new(Command::SAMConfiguration, [0x1, 0x14, 0]), 0)
    //     .unwrap();

    // println!("Scan card now!");
    // if let Ok(uid) = pn532.process(&Request::INLIST_ONE_ISO_A_TARGET, 26) {
    //     let uid: [u8; 10] = uid.try_into().unwrap();
    //     println!("uid: {:x?}", uid);

    //     let mut param = Vec::new();
    //     param.push(0x01);
    //     param.push(MifareCommand::AuthenticationWithKeyA as u8);
    //     param.push(0); // block number
    //     param.extend_from_slice(b"\xff\xff\xff\xff\xff\xff"); // key
    //     param.extend_from_slice(&uid[6..]); // uid
    //     let param: [u8; 13] = param.try_into().unwrap();
    //     let result = pn532.process(&Request::new(Command::InDataExchange, param), 1);
    //     println!("auth result: {:x?}", result);

    //     let block_to_read = 1;
    //     let result = pn532
    //         .process(
    //             &Request::new(
    //                 Command::InDataExchange,
    //                 [0x01, MifareCommand::Read as u8, block_to_read],
    //             ),
    //             17,
    //         )
    //         .unwrap();
    //     println!("read block {}: {:x?}", block_to_read, result);
    // }

    let manufacturer_name_characteristic = Characteristic::new(BleUuid::Uuid16(0x2A29))
        .name("Manufacturer Name String")
        .permissions(AttributePermissions::new().read().write())
        .properties(CharacteristicProperties::new().read().write().notify())
        .max_value_length(20)
        .on_write(|data, param| {
            println!("Received write request: {:?} {:?}", data, param);
        })
        .show_name()
        .set_value("Hello, world!".as_bytes().to_vec())
        .build();

    let device_information_service = Service::new(BleUuid::Uuid16(0x180A))
        .name("Device Information")
        .primary()
        .characteristic(&manufacturer_name_characteristic)
        .build();

    let profile = Profile::new(0x0001)
        .name("Device Information")
        .service(&device_information_service)
        .build();

    GLOBAL_GATT_SERVER
        .lock()
        .unwrap()
        .profile(profile)
        .device_name("ESP32-GATT-Server")
        .appearance(Appearance::WristWornPulseOximeter)
        .advertise_service(&device_information_service)
        .start();

    println!("DONE");
    loop {
        std::thread::sleep(Duration::from_millis(100));
    }
}
