// lib/features/timetable/presentation/pages/add_timetable_entry_page.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/services/timetable_service.dart';

const _bg = Color(0xFF150F2E);
const _cardBg = Color(0xFF1F1840);
const _textPrimary = Color(0xFFF4F2FF);
const _textSecondary = Color(0xFF8E84BE);
const _amber = Color(0xFFEF9F27);
const _red = Color(0xFFE24B4A);

class AddTimetableEntryPage extends StatefulWidget {
  final String groupId;
  const AddTimetableEntryPage({super.key, required this.groupId});

  @override
  State<AddTimetableEntryPage> createState() => _AddTimetableEntryPageState();
}

class _AddTimetableEntryPageState extends State<AddTimetableEntryPage> {
  bool _isClassMode = true;
  final _subjectCtrl = TextEditingController();
  final _titleCtrl = TextEditingController();
  final _roomCtrl = TextEditingController();
  String _day = 'Mon';
  TimeOfDay _startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 10, minute: 0);
  DateTime _dueAt = DateTime.now().add(const Duration(days: 1));
  bool _submitting = false;

  @override
  void dispose() {
    _subjectCtrl.dispose(); _titleCtrl.dispose(); _roomCtrl.dispose();
    super.dispose();
  }

  String _fmtTime(TimeOfDay t) => '${t.hour}:${t.minute.toString().padLeft(2, '0')}';

  Future<void> _submit() async {
    if (_subjectCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Add a subject first')));
      return;
    }
    setState(() => _submitting = true);
    try {
      final result = _isClassMode
          ? await TimetableService.addEntry(
              groupId: widget.groupId, subject: _subjectCtrl.text, day: _day,
              startTime: _fmtTime(_startTime), endTime: _fmtTime(_endTime), room: _roomCtrl.text)
          : await TimetableService.addAssignment(
              groupId: widget.groupId, subject: _subjectCtrl.text, title: _titleCtrl.text, dueAt: _dueAt);

      if (!mounted) return;
      if (result == TimetableEntryResult.success) {
        HapticFeedback.lightImpact();
        Navigator.of(context).pop(true);
      } else if (result == TimetableEntryResult.notAdmin) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Only your class rep can post to the timetable')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sign in to continue')));
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(backgroundColor: _bg, elevation: 0,
        title: Text('Add to timetable', style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w600, color: _textPrimary))),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Expanded(child: _ModeChip(label: 'Class', selected: _isClassMode, selectedColor: _amber, onTap: () => setState(() => _isClassMode = true))),
            const SizedBox(width: 10),
            Expanded(child: _ModeChip(label: 'Assignment', selected: !_isClassMode, selectedColor: _red, onTap: () => setState(() => _isClassMode = false))),
          ]),
          const SizedBox(height: 20),
          _field(_subjectCtrl, 'Subject', 'e.g. Physics'),
          const SizedBox(height: 14),
          if (_isClassMode) ...[
            Text('Day', style: GoogleFonts.dmSans(fontSize: 12, color: _textSecondary)),
            const SizedBox(height: 6),
            Wrap(spacing: 8, children: ['Mon','Tue','Wed','Thu','Fri'].map((d) => GestureDetector(
              onTap: () => setState(() => _day = d),
              child: Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(color: _day == d ? _amber : _cardBg, borderRadius: BorderRadius.circular(10)),
                child: Text(d, style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w600,
                  color: _day == d ? Colors.black : _textPrimary))),
            )).toList()),
            const SizedBox(height: 14),
            Row(children: [
              Expanded(child: _timeField('Start', _startTime, (t) => setState(() => _startTime = t))),
              const SizedBox(width: 10),
              Expanded(child: _timeField('End', _endTime, (t) => setState(() => _endTime = t))),
            ]),
            const SizedBox(height: 14),
            _field(_roomCtrl, 'Room', 'e.g. Room 202'),
          ] else ...[
            _field(_titleCtrl, 'Assignment title', 'e.g. Thermodynamics essay'),
            const SizedBox(height: 14),
            GestureDetector(
              onTap: () async {
                final picked = await showDatePicker(context: context, initialDate: _dueAt,
                  firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 365)),
                  builder: (context, child) => Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.dark(primary: _isClassMode ? _amber : _red, onPrimary: Colors.black,
                        surface: _cardBg, onSurface: _textPrimary),
                    ),
                    child: child!,
                  ));
                if (picked != null) setState(() => _dueAt = DateTime(picked.year, picked.month, picked.day, _dueAt.hour, _dueAt.minute));
              },
              child: Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                decoration: BoxDecoration(color: _cardBg, borderRadius: BorderRadius.circular(10)),
                child: Text('Due ${_dueAt.day}/${_dueAt.month}/${_dueAt.year}',
                  style: GoogleFonts.dmSans(fontSize: 13, color: _textPrimary))),
            ),
          ],
          const SizedBox(height: 28),
          SizedBox(width: double.infinity, child: ElevatedButton(
            onPressed: _submitting ? null : _submit,
            style: ElevatedButton.styleFrom(backgroundColor: _isClassMode ? _amber : _red, padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            child: _submitting
                ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black))
                : Text('Post to timetable', style: GoogleFonts.dmSans(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 14)),
          )),
        ]),
      ),
    );
  }

  Widget _field(TextEditingController ctrl, String label, String hint) => Column(
    crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: GoogleFonts.dmSans(fontSize: 12, color: _textSecondary)),
      const SizedBox(height: 6),
      TextField(controller: ctrl, style: GoogleFonts.dmSans(fontSize: 13, color: _textPrimary),
        decoration: InputDecoration(hintText: hint, hintStyle: GoogleFonts.dmSans(color: _textSecondary),
          filled: true, fillColor: _cardBg, border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12))),
    ]);

  Widget _timeField(String label, TimeOfDay time, ValueChanged<TimeOfDay> onPick) => GestureDetector(
    onTap: () async {
      final picked = await showTimePicker(context: context, initialTime: time,
        builder: (context, child) => Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(primary: _isClassMode ? _amber : _red, onPrimary: Colors.black,
              surface: _cardBg, onSurface: _textPrimary),
          ),
          child: child!,
        ));
      if (picked != null) onPick(picked);
    },
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: GoogleFonts.dmSans(fontSize: 12, color: _textSecondary)),
      const SizedBox(height: 6),
      Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(color: _cardBg, borderRadius: BorderRadius.circular(10)),
        child: Text(_fmtTime(time), style: GoogleFonts.dmSans(fontSize: 13, color: _textPrimary))),
    ]));
}

class _ModeChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Color selectedColor;
  final VoidCallback onTap;
  const _ModeChip({required this.label, required this.selected, required this.selectedColor, required this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(color: selected ? selectedColor : _cardBg, borderRadius: BorderRadius.circular(10)),
      child: Text(label, textAlign: TextAlign.center, style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w700,
        color: selected ? Colors.black : _textPrimary))));
}