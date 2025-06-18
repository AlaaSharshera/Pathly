import 'package:flutter/material.dart';
import 'package:pathly/utils/textstyles.dart';
import 'package:pathly/widgets/build_card.dart';


class AccountDialogCard extends StatelessWidget {
  const AccountDialogCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromARGB(0, 112, 104, 104),
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.9,
        
        decoration: BoxDecoration(
          color: Color(0xffE2EBF2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(

          children: [
            
            Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
            Container(
               height: MediaQuery.of(context).size.height * 0.68,
            width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(50),bottomLeft: Radius.circular(50)),
            ),
              child: Column(
                
                children: [
               
                 Column(
                   children: [
                     Padding(
                       padding: const EdgeInsets.only(left: 12,top: 12,bottom: 8),
                       child: Row(
                        
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: CircleAvatar(radius: 25,
                              backgroundImage:AssetImage("assets/images/profile.png"),
                            ),
                          ),            
                       
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("alaa sharshera",style:Styles.styledarkblack16bold),
                                    
                                ],
                              ),
                              Text("sharsheraalaa@gmail.com",style:Styles.styledarkgrey14),
                            ],
                          ), 
                         
                          
                        ],
                       ),
                     ),
                      OutlinedButton(
                      onPressed: () {},
                      child: Text('Manage your account',style:Styles.styleblack16 ,),
                    ),
                   ],
                 ),
                  Divider(height:20 ,),
                  BuildCard(icon: "assets/icons/incognito.svg",title:  'Turn on Incognito mode',onTap: (){},),
                  BuildCard(icon: "assets/icons/profile-fill.svg",title:  'Your Profile',onTap: (){},),
                  BuildCard(icon: "assets/icons/timeline.svg",title:  'Your timeline',onTap: (){},),
                  BuildCard(icon: "assets/icons/location-share.svg",title:  'Location Sharing',onTap: (){},),
                  BuildCard(icon: "assets/icons/offline.svg",title:  'Offline maps',onTap: (){},),
                  BuildCard(icon: "assets/icons/business.svg",title:  'Add your business',onTap: (){},),
                  BuildCard(icon: "assets/icons/data-user.svg",title:  'Your data in maps',onTap: (){},),
                  BuildCard(icon: "assets/icons/help.svg",title:  'Help & Feedback',onTap: (){},),
                
                
                ],
              ),
            ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(onPressed: () {}, child: Text('Privacy Policy',style: Styles.styledarkgrey14)),
                  Text('.'),
                  TextButton(onPressed: () {}, child: Text('Terms of service',style: Styles.styledarkgrey14)),
                ],
              ),
          ],
        ),
      ),
    );
  }

  
}
