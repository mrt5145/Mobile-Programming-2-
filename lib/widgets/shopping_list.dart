import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hw2/models/transactions.dart';
import 'package:provider/provider.dart';
import '../constant.dart';

class ShoppingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final transactions = Provider.of<Transactions>(context, listen: true);
    ScreenUtil.init(context,
        designSize: Size(1080, 1920), allowFontScaling: true);
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: transactions.getAllTransactions(),
      builder: (ctx, snap) => snap.connectionState == ConnectionState.done
          ? ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => Dismissible(
                background: Container(color: Colors.red),
                key: Key('${snap.data[index]['_id']}'),
                onDismissed: (direction) async {
                  await transactions.deleteTransaction(snap.data[index]['_id']);
                },
                child: Container(
                  height: kSpacingUnit.h * 3,
                  margin: EdgeInsets.only(bottom: kSpacingUnit.h * 0.4),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Card(
                      child: Row(
                        children: [
                          SizedBox(
                            width: kSpacingUnit.w * 1,
                          ),
                          IconButton(
                            iconSize: kSpacingUnit.w * 1.75,
                            icon: snap.data.elementAt(index)['isChecked'] == 0
                                ? Icon(Icons.check_circle, color: Colors.green)
                                : Icon(Icons.circle),
                            onPressed: () async {
                              Map<String, dynamic> newRow = {
                                ...snap.data[index]
                              };
                              newRow['isChecked'] == 1
                                  ? newRow['isChecked'] = 0
                                  : newRow['isChecked'] = 1;
                              await transactions.update(newRow);
                            },
                          ),
                          SizedBox(
                            width: kSpacingUnit.w * 1.5,
                          ),
                          Text(
                            snap.data.elementAt(index)['name'],
                            style: TextStyle(
                              fontSize:
                                  ScreenUtil().setSp(kSpacingUnit.h * 2.5),
                              decoration: snap.data[index]['isChecked'] == 0
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding:
                                EdgeInsets.only(right: kSpacingUnit.w * 1.25),
                            child: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              iconSize: kSpacingUnit.w * 1.75,
                              onPressed: () async {
                                await transactions
                                    .deleteTransaction(snap.data[index]['_id']);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              itemCount: snap.data.length,
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
