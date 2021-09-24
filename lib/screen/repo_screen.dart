import 'package:flutter/material.dart';
import 'package:githubfinal/providers/repo_provider.dart';
import 'package:githubfinal/screen/info_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class RepositiriesScreen extends StatefulWidget {
  String username;
  RepositiriesScreen(this.username);
  @override
  _RepositiriesScreenState createState() => _RepositiriesScreenState();
}

class _RepositiriesScreenState extends State<RepositiriesScreen> {
  var _init = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<RepositriesProvider>(context)
          .getRepositriesList(widget.username)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _init = false;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final repoData = Provider.of<RepositriesProvider>(context);
    final dateF = new DateFormat.yMMMMd("en_US");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.username),
        backgroundColor: Color(0xFF036BF3),
        centerTitle: true,
        elevation: 0,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: repoData.repoList.length,
              itemBuilder: (ctx, index) => InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => InfoScreen(
                          repoData.repoList[index].repo_name,
                          repoData.repoList[index].url)));
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffd9d9d9), width: 2),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          height: 40,
                          width: double.infinity,
                          color: Color(0xffd9d9d9),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  repoData.repoList[index].repo_name,
                                  style: TextStyle(
                                      fontSize: size.width * 0.05,
                                      fontWeight: FontWeight.w500),
                                )),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Created :',
                              style: TextStyle(
                                  fontSize: size.width * 0.04,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff595959)),
                            ),
                            Text(dateF.format(DateTime.parse(
                                repoData.repoList[index].created_date)))
                          ],
                        ),
                      ),
                      repoData.repoList[index].description == null
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Description :',
                                    style: TextStyle(
                                        fontSize: size.width * 0.04,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff595959)),
                                  ),
                                  Container(
                                      width: 150,
                                      child: Text(
                                          repoData.repoList[index].description))
                                ],
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Last Pushed : ',
                              style: TextStyle(
                                  fontSize: size.width * 0.04,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff595959)),
                            ),
                            Text(dateF.format(DateTime.parse(
                                repoData.repoList[index].last_pushed)))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Branch : ',
                              style: TextStyle(
                                  fontSize: size.width * 0.04,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff595959)),
                            ),
                            Text(repoData.repoList[index].branch)
                          ],
                        ),
                      ),
                      Container(
                          height: size.height * 0.05,
                          width: double.infinity,
                          color: Color(0xffd9d9d9),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                    'Stars: ${repoData.repoList[index].stars.toString()}'),
                                Text(
                                    '${repoData.repoList[index].language.toString()}'),
                              ],
                            ),
                          )),
                      //  Text('${url}')
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
