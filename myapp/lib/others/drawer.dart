import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:myapp/login.dart';
import 'package:get/get.dart';
import '../sharedPreference_auth.dart';

var drawer = Drawer(
  backgroundColor: Color(0xFFB1F2B36),
  child: Column(
    children: [
      Stack(
        children: [
          Image.network(
            "https://c4.wallpaperflare.com/wallpaper/319/190/501/carbon-fiber-minimalism-gray-black-background-dark-hd-wallpaper-preview.jpg",
            fit: BoxFit.contain,
            height: 200,
          ),
          AvatarGlow(
            endRadius: 80,
            glowColor: Colors.blue,
            child: Material(
              elevation: 12,
              shape: CircleBorder(),
              child: CircleAvatar(
                radius: 35,
                backgroundColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ClipOval(
                    child: Image.asset(
                      "assets/images/rrr-modified.png",
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 120,
            left: 50,
            child: Text(
              "Razu ahmed",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Rokkitt",
                fontSize: 18,
              ),
            ),
          ),
          Positioned(
            top: 135,
            left: 50,
            child: Text(
              "razuahmed8641@gmail.com",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Rokkitt",
                fontSize: 18,
              ),
            ),
          ),
          Positioned(
            top: 135,
            left: 260,
            child: Icon(
              Icons.arrow_drop_down,
              color: Colors.white,
            ),
          ),
        ],
      ),
      Column(
        children: [
          Container(
            color: Color.fromARGB(255, 75, 79, 91).withOpacity(0.2),
            child: ListTile(
              onTap: () {},
              leading: Icon(
                Icons.mail,
                color: Colors.white,
              ),
              title: Text(
                "Inbox",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Raleway",
                ),
              ),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              (Icons.send),
              color: Colors.white,
            ),
            title: Text("Outbox",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Raleway",
                )),
            iconColor: Colors.white,
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              (Icons.favorite_rounded),
              color: Colors.white,
            ),
            title: Text("Favourite",
                style: TextStyle(color: Colors.white, fontFamily: "Raleway")),
            iconColor: Colors.white,
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              (Icons.archive_rounded),
              color: Colors.white,
            ),
            title: Text("Archieve",
                style: TextStyle(color: Colors.white, fontFamily: 'Raleway')),
            iconColor: Colors.white,
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              (Icons.delete),
              color: Colors.white,
            ),
            title: Text("Trash",
                style: TextStyle(color: Colors.white, fontFamily: 'Raleway')),
            iconColor: Colors.white,
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              (Icons.report),
              color: Colors.white,
            ),
            title: Text("Spam",
                style: TextStyle(color: Colors.white, fontFamily: 'Raleway')),
            iconColor: Colors.white,
          ),
          Divider(
            thickness: 0.2,
            color: Colors.blueGrey,
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              (Icons.person),
              color: Colors.white,
            ),
            title: Text("Profile",
                style: TextStyle(color: Colors.white, fontFamily: 'Raleway')),
            // subtitle: Text("info"),

            iconColor: Colors.white,
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              (Icons.settings),
              color: Colors.white,
            ),
            title: Text("Settings",
                style: TextStyle(color: Colors.white, fontFamily: 'Raleway')),
            iconColor: Colors.white,
          ),
          ListTile(
            onTap: () async {
              // await FirebaseAuth.instance.signOut();
              // Navigator.pushNamed(context, LoginPage.path);
              SaveUserAuth.removeCredential();

              Get.to(LoginPage());
            },
            leading: Icon(
              (Icons.exit_to_app),
              color: Colors.white,
            ),
            title: Text("Logout",
                style: TextStyle(color: Colors.white, fontFamily: 'Raleway')),
            iconColor: Colors.white,
          ),
        ],
      )
    ],
  ),
);
