import 'package:flutter/material.dart';

class DatePickerFrom extends StatefulWidget {
  final void Function(String datefrom) datetimeFrom;
  DatePickerFrom(this.datetimeFrom);

  @override
  _DatePickerFromState createState() => _DatePickerFromState();
}

class _DatePickerFromState extends State<DatePickerFrom> {
  var selectedDateFrom;
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDateFrom)
      setState(() {
        selectedDateFrom = picked;
        widget.datetimeFrom(selectedDateFrom.toString());
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black45),
          borderRadius: BorderRadius.all(Radius.circular(40))),
      child: ListTile(
        leading: Icon(Icons.date_range),
        title: selectedDateFrom == null
            ? Text(
                'Please select date from',
                style: TextStyle(color: Colors.black54),
              )
            : Text(
                "${selectedDateFrom.toLocal()}".split(' ')[0],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
        onTap: () => _selectDate(context),
      ),
    );
  }
}

class DatePickerTo extends StatefulWidget {
  final void Function(String dateTo) datetimeTO;
  DatePickerTo(this.datetimeTO);

  @override
  _DatePickerToState createState() => _DatePickerToState();
}

class _DatePickerToState extends State<DatePickerTo> {
  var selectedDateTO;
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDateTO)
      setState(() {
        selectedDateTO = picked;
        widget.datetimeTO(selectedDateTO.toString());
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black45),
          borderRadius: BorderRadius.all(Radius.circular(40))),
      child: ListTile(
        leading: Icon(Icons.date_range),
        title: selectedDateTO == null
            ? Text(
                'Please select date to',
                style: TextStyle(color: Colors.black54),
              )
            : Text(
                "${selectedDateTO.toLocal()}".split(' ')[0],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
        onTap: () => _selectDate(context),
      ),
    );
  }
}
