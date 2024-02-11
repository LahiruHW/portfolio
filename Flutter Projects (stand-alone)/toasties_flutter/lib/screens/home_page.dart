import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toasties_flutter/common/providers/index.dart';
import 'package:toasties_flutter/common/utility/newsapi_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ToastieStateProvider>(
      builder: (context, stateProvider, child) => Scaffold(
        body: 
        

        // build a sliver list view with sticky headers

        CustomScrollView(
          slivers: <Widget>[


            SliverList(
              
              delegate: SliverChildBuilderDelegate(
                
                (context, index) {
                  
                  return SliverToBoxAdapter(
                    child: NewsAPIServices.buildEverythingTabView(),
                  );

                },
              ),
              
            ),
          ],
        ),



        // Container(
        //   padding: const EdgeInsets.all(10),
        //   child: NewsAPIServices.buildEverythingTabView(),
        // ),



      ),
    );
  }
}
