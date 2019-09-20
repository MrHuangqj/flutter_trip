import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/sales_box_model.dart';
import 'package:flutter_trip/widget/webview.dart';

class SalesBox extends StatelessWidget {
  final SalesBoxModel saleBox;

  SalesBox({Key key, @required this.saleBox}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
      ),
      child: _items(context),
    );
  }

  _items(BuildContext context) {
    if (saleBox == null) return null;
    List<Widget> items = [];
    //添加卡片
    items.add(
        _doubleItem(context, saleBox.bigCard1, saleBox.bigCard2, true, false));
    items.add(_doubleItem(
        context, saleBox.smallCard1, saleBox.smallCard2, false, false));
    items.add(_doubleItem(
        context, saleBox.smallCard3, saleBox.smallCard4, false, true));

    //计算每一行显示的数量
    return Column(
      children: <Widget>[
        Container(
          height: 44,
          margin: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 1, color: Color(0xfff2f2f2)))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.network(
                saleBox.icon,
                height: 15,
                fit: BoxFit.fill,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 1, 8, 1),
                margin: EdgeInsets.only(right: 7),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xffff4e63),
                        Color(0xffff6cc9),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    )),
                child: Text(
                  "获取更多福利>",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(0, 1),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(1, 2),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(2, 3),
        ),
      ],
    );
  }

  /**
   * @Description:生成两个卡片的组件方法
   * @param：leftCart:左边卡片信息；rigthCart:右边卡片信息；big：判断是否是大卡片；last：判断是否为最后一列卡片
   */
  _doubleItem(BuildContext context, CommonModel leftCard, CommonModel rigthCart,
      bool big, bool last) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _item(context, leftCard, big, true, last),
        _item(context, rigthCart, big, false, last),
      ],
    );
  }

  Widget _item(
      BuildContext context, CommonModel model, bool big, bool left, bool last) {
    BorderSide borderSide = BorderSide(width: 0.8, color: Color(0xfff2f2f2));

    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WebView(
                        url: model.url,
                        statusBarColor: model.statusBarColor,
                        hideAppBar: model.hideAppBar,
                      )));
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  right: left ? borderSide : BorderSide.none,
                  bottom: last ? BorderSide.none : borderSide)),
          child: Image.network(
            model.icon,
            height: big ? 129 : 80,
            width: MediaQuery.of(context).size.width / 2 - 10, //获取屏幕宽度
          ),
        ));
  }
}
