import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

bool roundUpSwitch = false;
double tipAmount = 0.0;
int? selected = 1;

var totalCostController = TextEditingController();

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Tip Time'),
      ),
      body: Column(
        children: [
          SizedBox(height: 25),
          ListTile(
            leading: Icon(
              Icons.add_business,
              color: Colors.green,
            ),
            title: TextFormField(
              keyboardType: TextInputType.number,
              controller: totalCostController,
              cursorColor: Colors.green,
              style: TextStyle(color: Colors.green),
              decoration: InputDecoration(
                labelText: 'Cost of Service',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green))),
            ),
          ),
          ListTile(
            leading: Icon(Icons.room_service, color: Colors.green),
            title: Text('How was the service?'),
          ),
          Column(
            children: [
              ListTile(
                title: Text('Amazing (20%)'),
                leading: Radio(
                    activeColor: Colors.green,
                    value: 1,
                    groupValue: selected,
                    onChanged: (int? value) {
                      setState(() {
                        selected = 1;
                      });
                    }),
              ),
              ListTile(
                title: Text('Good (15%)'),
                leading: Radio(
                    activeColor: Colors.green,
                    value: 2,
                    groupValue: selected,
                    onChanged: (int? value) {
                      setState(() {
                        selected = value;
                      });
                    }),
              ),
              ListTile(
                title: Text('OK (10%)'),
                leading: Radio(
                    activeColor: Colors.green,
                    value: 3,
                    groupValue: selected,
                    onChanged: (int? value) {
                      setState(() {
                        selected = value;
                      });
                    }),
              ),
            ],
          ),
          ListTile(
            title: Text('Round up tip?'),
            leading: Icon(Icons.credit_card),
            trailing: Switch(
              activeColor: Colors.green,
              value: roundUpSwitch,
              onChanged: (value) {
                roundUpSwitch = !roundUpSwitch;
                setState(() {});
              },
            ),
          ),
          SizedBox(
            child: MaterialButton(
                color: Colors.green,
                child: Text('CALCULATE'),
                onPressed: selectTip),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Tip Amount: ${tipAmount.toStringAsFixed(2)}',
                textAlign: TextAlign.end,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void selectTip() {
    if (totalCostController.text == '') {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
            SnackBar(content: Text('Por favor escriba el costo del servicio')));
    } else {
      _tipCalculation();
    }
    setState(() {});
  }
}

void _tipCalculation() {
  double costService = double.parse(totalCostController.text);
  print(selected);
  switch (selected) {
    case 1:
      tipAmount = costService + costService * .20;
      break;
    case 2:
      tipAmount = costService + costService * .18;
      break;
    case 3:
      tipAmount = costService + costService * .15;
      break;
    default:
      tipAmount = 0;
  }
  if (roundUpSwitch) {
    tipAmount = tipAmount.ceil().toDouble();
  } else {
    tipAmount = tipAmount;
  }
}
