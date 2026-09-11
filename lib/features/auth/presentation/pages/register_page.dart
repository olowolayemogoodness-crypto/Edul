import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../../../../core/services/user_service.dart';
import '../../../../core/services/group_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _firstCtrl = TextEditingController();
  final _lastCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  List<Map<String, dynamic>> _officialGroups = [];
  Map<String, dynamic>? _selectedDepartmentGroup;
  int? _mySet;
  bool _obscure = true, _obscureConfirm = true;
  int _strength = 0;

  @override
  void initState() {
    super.initState();
    _loadDepartments();
  }

  Future<void> _loadDepartments() async {
    final prefs = await SharedPreferences.getInstance();
    final level = prefs.getString('user_level');
    final set = level != null ? GroupService.setForLevel(level) : null;
    if (set == null) return; // no level saved, or a level with no matching set (postgrad) -- picker just stays empty
    _mySet = set;
    final groups = await GroupService.officialGroups(set: set);
    if (mounted) setState(() => _officialGroups = groups);
  }

  @override
  void dispose() {
    _firstCtrl.dispose(); _lastCtrl.dispose();
    _emailCtrl.dispose(); _passCtrl.dispose(); _confirmCtrl.dispose();
    super.dispose();
  }

  void _onPassChange(String val) {
    int s = 0;
    if (val.length >= 6) s++;
    if (val.contains(RegExp(r'[A-Z]'))) s++;
    if (val.contains(RegExp(r'[0-9]'))) s++;
    if (val.contains(RegExp(r'[!@#\$%^&*]'))) s++;
    setState(() => _strength = s);
  }

  Future<void> _pickDepartment() async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      backgroundColor: AppColors.background,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => _DepartmentPickerSheet(groups: _officialGroups),
    );
    if (result != null) setState(() => _selectedDepartmentGroup = result);
  }

  Future<void> _register() async {
    final first = _firstCtrl.text.trim();
    final last = _lastCtrl.text.trim();
    final email = _emailCtrl.text.trim();
    final pass = _passCtrl.text;
    final confirm = _confirmCtrl.text;

    if (first.isEmpty || last.isEmpty) { _showError('Please enter your first and last name.'); return; }
    if (email.isEmpty) { _showError('Please enter your email.'); return; }
    if (pass.length < 6) { _showError('Password must be at least 6 characters.'); return; }
    if (pass != confirm) { _showError('Passwords do not match.'); return; }
    if (_selectedDepartmentGroup == null) { _showError('Please select your course.'); return; }

    final department = _selectedDepartmentGroup!['department'] as String;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_course', department);

    HapticFeedback.lightImpact();
    context.read<AuthBloc>().add(AuthRegister(
      name: '$first $last',
      email: email,
      password: pass,
    ));
  }

  void _signInGoogle() {
    HapticFeedback.lightImpact();
    context.read<AuthBloc>().add(const AuthSignInWithGoogle());
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg, style: GoogleFonts.dmSans(fontSize: 13)),
      backgroundColor: AppColors.error,
      behavior: SnackBarBehavior.floating,
    ));
  }

  Color get _strengthColor => _strength <= 1 ? AppColors.error : _strength == 2 ? AppColors.warning : AppColors.success;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (ctx, state) async {
        if (state is AuthAuthenticated) {
          final department = _selectedDepartmentGroup?['department'] as String?;
          if (department != null && _mySet != null) {
            await UserService.updateProfile(course: department, set: _mySet!);
            await GroupService.autoJoinOfficialDepartment(department, set: _mySet!);
          }
          if (ctx.mounted) ctx.go('/subject-picker');
        }
        if (state is AuthError) _showError(state.message);
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(child: SingleChildScrollView(padding: const EdgeInsets.all(24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          GestureDetector(onTap: () => context.go('/login'), child: Icon(Icons.arrow_back_rounded, size: 20, color: AppColors.textTertiary)),
          const SizedBox(height: 18),
          Text('Create account', style: GoogleFonts.dmSans(fontSize: 22, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
          const SizedBox(height: 4),
          Text('Start your learning journey today', style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary)),
          const SizedBox(height: 24),
          // First + Last name row
          Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _label('First name'),
              _field(ctrl: _firstCtrl, hint: 'Ore'),
            ])),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _label('Last name'),
              _field(ctrl: _lastCtrl, hint: 'Mowo'),
            ])),
          ]),
          const SizedBox(height: 12),
          _label('Email'),
          _field(ctrl: _emailCtrl, hint: 'you@example.com', type: TextInputType.emailAddress),
          const SizedBox(height: 12),
          _label('Course'),
          GestureDetector(
            onTap: _pickDepartment,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.surface, borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.border)),
              child: Row(children: [
                Expanded(child: Text(
                  _selectedDepartmentGroup?['department'] as String? ?? 'Select your course',
                  style: GoogleFonts.dmSans(fontSize: 13,
                    color: _selectedDepartmentGroup != null ? AppColors.textPrimary : AppColors.textDisabled))),
                Icon(Icons.expand_more_rounded, color: AppColors.textTertiary, size: 20),
              ]),
            ),
          ),
          const SizedBox(height: 12),
          _label('Password'),
          _passField(_passCtrl, _obscure, () => setState(() => _obscure = !_obscure), onChanged: _onPassChange),
          if (_passCtrl.text.isNotEmpty) ...[
            const SizedBox(height: 6),
            Row(children: List.generate(4, (i) => Expanded(child: Container(
              margin: EdgeInsets.only(right: i < 3 ? 4 : 0),
              height: 3, decoration: BoxDecoration(color: i < _strength ? _strengthColor : AppColors.border, borderRadius: BorderRadius.circular(2)),
            )))),
          ],
          const SizedBox(height: 12),
          _label('Confirm password'),
          _passField(_confirmCtrl, _obscureConfirm, () => setState(() => _obscureConfirm = !_obscureConfirm)),
          const SizedBox(height: 20),
          BlocBuilder<AuthBloc, AuthState>(builder: (ctx, state) {
            final loading = state is AuthLoading;
            return GestureDetector(
              onTap: loading ? null : _register,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(12)),
                child: Center(child: loading
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : Text('Create account', style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white))),
              ),
            );
          }),
          const SizedBox(height: 16),
          _divider(),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: _signInGoogle,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(color: AppColors.surface, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(12)),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(width: 18, height: 18, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: Center(child: Text('G', style: GoogleFonts.dmSans(fontSize: 10, fontWeight: FontWeight.w700, color: const Color(0xFF4285F4))))),
                const SizedBox(width: 8),
                Text('Continue with Google', style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textSecondary)),
              ]),
            ),
          ),
          const SizedBox(height: 20),
          Center(child: GestureDetector(
            onTap: () => context.go('/login'),
            child: RichText(text: TextSpan(children: [
              TextSpan(text: 'Have an account? ', style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary)),
              TextSpan(text: 'Sign in', style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.accentLight, fontWeight: FontWeight.w500)),
            ])),
          )),
          const SizedBox(height: 16),
        ]))),
      ),
    );
  }

  Widget _label(String t) => Padding(padding: const EdgeInsets.only(bottom: 6), child: Text(t, style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary)));

  Widget _field({required TextEditingController ctrl, required String hint, TextInputType type = TextInputType.text}) => TextField(
    controller: ctrl, keyboardType: type,
    style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textPrimary),
    decoration: InputDecoration(hintText: hint, hintStyle: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textDisabled),
      filled: true, fillColor: AppColors.surface,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.border)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.border)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.accent)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    ),
  );

  Widget _passField(TextEditingController ctrl, bool obscure, VoidCallback toggle, {ValueChanged<String>? onChanged}) => TextField(
    controller: ctrl, obscureText: obscure, onChanged: onChanged,
    style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textPrimary),
    decoration: InputDecoration(
      hintText: '••••••••', hintStyle: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textDisabled),
      filled: true, fillColor: AppColors.surface,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.border)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.border)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.accent)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      suffixIcon: GestureDetector(onTap: toggle, child: Icon(obscure ? Icons.visibility_off_rounded : Icons.visibility_rounded, size: 18, color: AppColors.textTertiary)),
    ),
  );

  Widget _divider() => Row(children: [
    Expanded(child: Divider(color: AppColors.border)),
    Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: Text('or', style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textTertiary))),
    Expanded(child: Divider(color: AppColors.border)),
  ]);
}

class _DepartmentPickerSheet extends StatefulWidget {
  final List<Map<String, dynamic>> groups;
  const _DepartmentPickerSheet({required this.groups});

  @override
  State<_DepartmentPickerSheet> createState() => _DepartmentPickerSheetState();
}

class _DepartmentPickerSheetState extends State<_DepartmentPickerSheet> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = widget.groups.where((g) {
      final dept = (g['department'] as String? ?? '').toLowerCase();
      return dept.contains(_query.toLowerCase());
    }).toList();

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Select your course', style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
              const SizedBox(height: 12),
              TextField(
                onChanged: (v) => setState(() => _query = v),
                style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Search…', hintStyle: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textDisabled),
                  prefixIcon: Icon(Icons.search_rounded, color: AppColors.textTertiary, size: 18),
                  filled: true, fillColor: AppColors.surface,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.border)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.border)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.accent)),
                ),
              ),
            ]),
          ),
          Flexible(
            child: widget.groups.isEmpty
                ? Padding(padding: const EdgeInsets.all(32),
                    child: Text('No courses available yet', style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textTertiary)))
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: filtered.length,
                    itemBuilder: (context, i) {
                      final g = filtered[i];
                      return ListTile(
                        title: Text(g['department'] as String? ?? '', style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textPrimary)),
                        onTap: () => Navigator.of(context).pop(g),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 12),
        ]),
      ),
    );
  }
}