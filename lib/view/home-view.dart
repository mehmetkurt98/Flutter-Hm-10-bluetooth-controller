import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color myColor = Color(0xFF063A34);
  Color soketColor = Color(0xFF03DABB);
  Color redColor =Color(0xFF0EF0909);
  Color dfcBackGround=Color(0xFF000FFDA);
  Color celciusBackGround = Color(0xFF0182724);
  Color dereceTextBackGround =Color(0xFF0CD3939);
  Color amperBackGround = Color(0xFF0182724);
  Color buttonBackground =Color(0xFF00CE8A6);
  Color startColor =Color(0xFF000FFDA);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [

          SizedBox(height: 80),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: SizedBox(
              width: 342,
              height: 130,
              child: Card(
                color: myColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 60,),
                        Icon(Icons.info_outline,color: Colors.white,),
                        SizedBox(width: 8,height: 40,), // İkon ile metin arasında boşluk
                        Text(
                          "Soket Bağlantısı Yok!",
                          style: TextStyle(
                            color: soketColor, // Metnin rengi
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Text("Lütfen Soketi Bağlayınız",style: TextStyle(color: redColor,fontSize: 14),),
                  ],

                ),
              ),
            ),
          ),
          SizedBox(height: 100,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 143,
                width: 174,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: dfcBackGround,
                  child: Row(
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "GFCI Bağlantı Başarılı",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 26,
                        height: 40,
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 20,),
              SizedBox(
                height: 143,
                width: 174,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // Kenarları yuvarlamak için BorderRadius.circular kullanılır
                  ),
                  color: celciusBackGround,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.device_thermostat_outlined,color: dereceTextBackGround,),
                      Text("50\u2103",style: TextStyle(color: dereceTextBackGround,fontSize: 44),),


                    ],
                  ),
                ),
              ),


            ],
          ),
          SizedBox(
            height: 105,
            width: 378,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0), // Kenarları yuvarlamak için BorderRadius.circular kullanılır
              ),
              color: amperBackGround,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Akım",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                  SizedBox(width: 10,),
                  Text("32A",style: TextStyle(color: dereceTextBackGround,fontSize: 45),),
                  SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.asset("assets/vector.png")),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
/*
              SizedBox(
                  width: 170,
                  height: 40,
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(buttonBackground)),

                      onPressed: (){}, child: Text("Start",style: TextStyle(color: startColor),))),
              SizedBox(width: 50,),

              SizedBox(
                  width: 170,
                  height: 40,
                  child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(buttonBackground)),

                      onPressed: (){}, child: Text("Stop"))),


 */
            ],
          ),
          Row(
            children: [
              SizedBox(
                  width: 170,
                  height: 60,
                  child: Image.asset("assets/img_1.png")),
              Padding(padding: EdgeInsets.all(20)),
              SizedBox(
                  width: 170,
                  height: 60,
                  child: Image.asset("assets/img_2.png")),



            ],
          )

        ],

      ),
    );
  }
}
