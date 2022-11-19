import 'package:localstorage/localstorage.dart';
import 'package:wyld_card/entities/card.dart';

class CardRepository{
  static const ownCards = "OWN_CARDS";
  static const savedCars = "SAVED_CARDS";

  final LocalStorage storage = new LocalStorage("mycards.json");
  final LocalStorage foreignStorage = new LocalStorage("foreignCards.json");

  Future<List<Buisiness_card>> getOwnCards() async{
    await storage.ready;
    if(await storage.ready == false){
      throw Error();
    }
    //List<Buisiness_card> cards = await storage.getItem(ownCards);
    return (await storage.getItem(ownCards)) != null ? _convertToList(await storage.getItem(ownCards)) : [];
  }

  Future<void> saveNewCard(Buisiness_card card) async{
    List<Buisiness_card> cards = await getOwnCards();
    await storage.setItem(ownCards ,_convertToJson(cards)..add(card.toJson()));
    if(card.mainCard){
      await changeMainCard(card);
    }
  }



  Future<void> deleteCard(Buisiness_card card) async{
    List<Buisiness_card> cards = await getOwnCards();
    cards.removeWhere((element) => element.id.value == card.id.value);
    storage.setItem(ownCards, _convertToJson(cards));
  }

  Future<void> changeMainCard(Buisiness_card card) async{
    List<Buisiness_card> cards = await getOwnCards();
    cards =  cards.map((e) => e.copyWith(mainCard: false)).toList();
    int indexNewMain =  cards.indexWhere((element) => element.id.value == card.id.value);
    cards[indexNewMain] = cards[indexNewMain].copyWith(mainCard: true);
    storage.setItem(ownCards, _convertToJson(cards));
  }




  ///--------------------------------------------------------------------
  ///-----------------------------EXTERNAL CARDS-------------------------
  ///--------------------------------------------------------------------


  Future<List<Buisiness_card>> getForeignCards() async{
    await foreignStorage.ready;
    if(await foreignStorage.ready == false){
      throw Error();
    }
    //List<Buisiness_card> cards = await storage.getItem(ownCards);
    return (await foreignStorage.getItem(savedCars)) != null ? _convertToList(await foreignStorage.getItem(savedCars)) : [];
  }


  Future<void> deleteForeignCard(Buisiness_card card) async{
    List<Buisiness_card> cards = await getForeignCards();
    cards.removeWhere((element) => element.id.value == card.id.value);
    foreignStorage.setItem(savedCars, _convertToJson(cards));
  }


  Future<void> saveNewForeignCard(Buisiness_card card) async{
    List<Buisiness_card> cards = await getForeignCards();
    await foreignStorage.setItem(savedCars ,_convertToJson(cards)..add(card.toJson()));
    if(card.mainCard){
      await changeMainCard(card);
    }
  }


  ///--------------------------------------------------------------------
  ///-----------------------------HELPER METHODS-------------------------
  ///--------------------------------------------------------------------


  void cleatStorage() async{
    await foreignStorage.ready;
    this.foreignStorage.clear();
    await storage.ready;
    this.storage.clear();
  }

  ///
  /// receives an JsonConvertable and converts to an List with [Buisiness_card]s
  ///
  List<Buisiness_card> _convertToList(List<dynamic> jsonList){
    return jsonList.map((e) => Buisiness_card.fromJson(e as Map<String, dynamic>)).toList();
  }


  ///
  /// converts to List of Maps
  /// this is done so it can be easyly saved as json
  ///
  List<Map<String, dynamic>> _convertToJson(List<Buisiness_card> cards){
    return cards.map((e) => e.toJson()).toList();
  }
}