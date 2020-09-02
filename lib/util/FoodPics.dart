class FoodPics{
  Map<String,String> picsMap = {
    "Oranges":"oranges.jpeg",
    "Kiwis" :"kiwis.jpeg",
    "Guava":"guava.jpeg",
    "Broccoli":"broccoli.jpeg",
    "Tomato":"tomato.jpeg",
    "Legumes":"legumes.jpeg",
    "Eggs":"eggs.jpeg",
    "Spinach":"spinach.jpeg",
    "Beetroot":"beetroot.jpeg",
    "Nuts":"nuts.jpeg",
    "Meat":"meat.jpeg",
    "Curd/Yogurt":"curd.jpeg",
     "Milk Prods": "milk_prods.jpeg",
    "Sunlight": "sunlight.jpeg",
    "Cheese":"cheese.jpeg",
    "Egg Yolk":"egg_yolk.jpeg",
    "Salmon":"salmon.jpeg",
    "Soybean":"soybean.jpeg",
    "Lentils":"lentils.jpeg",
    "Tofu":"tofu.jpeg",
    "Raisins":"raisins.jpeg",
    "Beans":"beans.jpeg",
    "Almonds":"almonds.jpeg",
    "Dark chocolate":"chocolates.jpeg",
    "Chicken":"",
    "Grains":"grains.jpeg",
    "Avocados":"avocados.jpeg",
    "Carrots":"carrot.jpeg",
    "Green Beans":"beans.jpeg",
    "Coconut":"coconut.jpeg",
    "Coconut water":"coco_water.jpeg",
    "Kidney beans":"kidney_beans.jpeg",
    "Oats":"oats.jpeg",
    "Pear":"pear.jpeg",
    "Apple":"apple.jpeg",
    "Banana":"banana.jpeg"
  };
  String getAssetName (String foodName){
    return picsMap[foodName];
  }
}