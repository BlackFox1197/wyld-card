use embedded_graphics::image::Image;
use embedded_graphics::image::ImageRawLE;
use esp_idf_hal::i2c::I2cConfig;
use esp_idf_hal::i2c::I2cDriver;
use esp_idf_sys as _; // If using the `binstart` feature of `esp-idf-sys`, always keep this module imported

use embedded_graphics::{
    mono_font::{ascii::FONT_6X10, MonoTextStyle},
    pixelcolor::BinaryColor,
    prelude::*,
    text::Text,
};
// use esp32::Peripherals;
//  use esp32_hal::spi::Spi;
//   use esp32_hal::IO;
// use esp32_hal::spi::SpiMode;
// use esp32_hal::clock::ClockControl;
// use esp32_hal::prelude::*;

use esp_idf_hal::gpio::*;
use esp_idf_hal::peripherals::Peripherals;
use esp_idf_hal::spi::*;
use esp_idf_hal::units::FromValueType;
use pn532::requests::{Command, MifareCommand};
use sh1106::builder::NoOutputPin;
use sh1106::{prelude::*, Builder};

fn main() -> anyhow::Result<()> {
    // Temporary. Will disappear once ESP-IDF 4.4 is released, but for now it is necessary to call this function once,
    // or else some patches to the runtime implemented by esp-idf-sys might not link properly.
    esp_idf_sys::link_patches();
    esp_idf_svc::log::EspLogger::initialize_default();

    let peripherals = Peripherals::take().unwrap();
    let spi = peripherals.spi2;

    // let dc = PinDriver::output(peripherals.pins.gpio15).unwrap();
    // let sclk = peripherals.pins.gpio6;
    // let sdo = peripherals.pins.gpio7; // -> MOSI
    // let sdi = peripherals.pins.gpio8;

    let dc = PinDriver::output(peripherals.pins.gpio16).unwrap();
    let sclk = peripherals.pins.gpio14;
    let sdo = peripherals.pins.gpio13; // -> MOSI
                                       // let sdi = peripherals.pins.gpio12;

    // dc 16
    // clk 14
    // mosi/sdo 13
    // cs 15
    // res 19

    let cs = peripherals.pins.gpio15;
    let cs_driver = PinDriver::output(cs).unwrap();

    // let cs = peripherals.pins.gpio18;
    // let cs_driver = PinDriver::output(cs).unwrap();

    let res = peripherals.pins.gpio19;
    let mut res = PinDriver::output(res).unwrap();
    res.set_high().unwrap();

    println!("ASD2");

    let config = config::Config::new()
        .baudrate(400.kHz().into())
        .write_only(true)
        .data_mode(embedded_hal::spi::MODE_0);
    println!("ASD");
    let spi = SpiDeviceDriver::new_single(
        spi,
        sclk,
        sdo,
        None::<Gpio12>,
        Dma::Disabled,
        None::<Gpio15>,
        &config,
    )?;
    println!("spi done");

    let mut disp: GraphicsMode<_> = Builder::new().connect_spi(spi, dc, cs_driver).into();
    println!("build done");

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

    use pn532::i2c::I2CInterface;
    use pn532::{Pn532, Request};

    // spi, cs and timer are structs implementing their respective embedded_hal traits.

    // DIP switch config for i2c
    // 1   # ON
    // 2 #   KE

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

    let i2c = peripherals.i2c0;
    let sda = peripherals.pins.gpio21;
    let scl = peripherals.pins.gpio22;
    // std::thread::sleep_ms(100);
    let config = I2cConfig::new().baudrate(10.kHz().into());
    let i2c = I2cDriver::new(i2c, sda, scl, &config)?;
    let interface = I2CInterface { i2c };
    println!("start pn532");
    // std::thread::sleep_ms(100);
    let mut pn532: Pn532<_, 128> = Pn532::new(interface);
    // std::thread::sleep_ms(100);
    println!("read pn532 1");
    loop {
        match pn532.process(&Request::GET_FIRMWARE_VERSION, 4) {
            Ok(ver) => {
                println!("{:?}", ver);
                break;
            }
            Err(e) => println!("{:?}", e),
        }
    }
    pn532.process(&Request::GET_FIRMWARE_VERSION, 4).unwrap();

    // match
    pn532
        .process(&Request::new(Command::SAMConfiguration, [0x1, 0x14, 0]), 0)
        .unwrap();

    // if let Ok(firmware_ver) = pn532.process(&Request::GET_FIRMWARE_VERSION, 4){
    //     println!("{:x?}", firmware_ver);
    //     println!("read pn532 2");
    println!("card???");
    if let Ok(uid) = pn532.process(&Request::INLIST_ONE_ISO_A_TARGET, 26) {
        let uid: [u8; 10] = uid.try_into().unwrap();
        println!("uid: {:?}", uid);

        let keys = [
            b"\xff\xff\xff\xff\xff\xff",
            // b"\xa0\xb0\xc0\xd0\xe0\xf0",
            // b"\xa1\xb1\xc1\xd1\xe1\xf1",
            // b"\xa0\xa1\xa2\xa3\xa4\xa5",
            // b"\xb0\xb1\xb2\xb3\xb4\xb5",
            // b"\x4d\x3a\x99\xc3\x51\xdd",
            // b"\x1a\x98\x2c\x7e\x45\x9a",
            // b"\x00\x00\x00\x00\x00\x00",
            // b"\xaa\xbb\xcc\xdd\xee\xff",
            // b"\xd3\xf7\xd3\xf7\xd3\xf7",
            // b"\xaa\xbb\xcc\xdd\xee\xff",
            // b"\x71\x4c\x5c\x88\x6e\x97",
            // b"\x58\x7e\xe5\xf9\x35\x0f",
            // b"\xa0\x47\x8c\xc3\x90\x91",
            // b"\x53\x3c\xb6\xc7\x23\xf6",
            // b"\x8f\xd0\xa4\xf2\x56\xe9",
        ];

        for key in keys {
            let mut param = Vec::new();
            param.push(0x01);
            param.push(MifareCommand::AuthenticationWithKeyA as u8);
            param.push(0); // block number
            param.extend_from_slice(key);
            param.extend_from_slice(&uid[6..]);
            println!("{:x?}", &param);
            let param: [u8; 13] = param.try_into().unwrap();
            let result = pn532.process(&Request::new(Command::InDataExchange, param), 1);
            println!("auth: {:?}", result);
        }


        let result = pn532.process(&Request::new(
            Command::InDataExchange,
            [0x01, MifareCommand::Read as u8, 1],
        ), 17).unwrap();
        println!("read: {:?}", result);
        if result[0] == 0x00 {
            println!("page 0: {:?}", &result[1..]);
        }
    }
    // }
    println!("DONE");
    loop {
        std::thread::sleep_ms(100);
    }

    // Ok(())

    // loop {}
}
