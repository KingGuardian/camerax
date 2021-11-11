import 'package:flutter/material.dart';

class AnalysisView extends StatelessWidget {
  final source = 'images/wifi.png';
  final type = 'WiFi';
  final format = 'QRCode';
  final contentType = 'string';
  final content = 'Mi WiFi';

  const AnalysisView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('扫描结果'),
      ),
      body: Padding(
        padding: EdgeInsets.all(40.0),
        child: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: Column(
            children: [
              Column(
                children: [
                  Image.asset(
                    source,
                    width: 40.0,
                    height: 40.0,
                  ),
                  Container(height: 8.0),
                  Text(
                    type,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0x99000000),
                    ),
                  ),
                ],
              ),
              Container(height: 40.0),
              Expanded(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '条码格式',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Container(height: 4.0),
                        Text(
                          format,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0x99000000),
                          ),
                        ),
                      ],
                    ),
                    Container(height: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '结果类型',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Container(height: 4.0),
                        Text(
                          contentType,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0x99000000),
                          ),
                        ),
                      ],
                    ),
                    Container(height: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '结果内容',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Container(height: 4.0),
                        Text(
                          content,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0x99000000),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(height: 40.0),
              ButtonTheme(
                minWidth: 188.0,
                height: 36.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0)),
                textTheme: ButtonTextTheme.primary,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('复制'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
