import 'package:flutter/material.dart';
import 'package:green_kitchen_ui/green_kitchen_ui.dart';

void main() {
  runApp(const GalleryApp());
}

/// Widget gallery for green_kitchen_ui, with a light/dark toggle.
class GalleryApp extends StatefulWidget {
  const GalleryApp({super.key});

  @override
  State<GalleryApp> createState() => _GalleryAppState();
}

class _GalleryAppState extends State<GalleryApp> {
  var _dark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Green Kitchen UI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: _dark ? ThemeMode.dark : ThemeMode.light,
      home: GalleryPage(
        dark: _dark,
        onToggleDark: (value) => setState(() => _dark = value),
      ),
    );
  }
}

class GalleryPage extends StatefulWidget {
  const GalleryPage({
    super.key,
    required this.dark,
    required this.onToggleDark,
  });

  final bool dark;
  final ValueChanged<bool> onToggleDark;

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  var _tab = 0;
  var _chips = <String>{'Vegan'};
  String? _cuisine;
  var _diet = <String>{'Balanced'};
  var _notify = true;
  var _spice = 0.4;
  var _servings = 2;
  var _agreed = false;
  var _page = 0;
  var _saving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppNavigationHeader(
        title: 'Green Kitchen UI',
        showBack: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: AppSwitch(value: widget.dark, onChanged: widget.onToggleDark),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          _Section(
            title: 'Typography',
            children: [
              for (final variant in AppTextVariant.values)
                AppText(variant.name, variant: variant),
            ],
          ),
          _Section(
            title: 'Buttons',
            children: [
              AppButton(
                label: 'Primary',
                isLoading: _saving,
                onPressed: () async {
                  setState(() => _saving = true);
                  await Future<void>.delayed(const Duration(seconds: 1));
                  if (mounted) setState(() => _saving = false);
                },
              ),
              AppButton(
                label: 'Soft',
                variant: AppButtonVariant.soft,
                onPressed: () {},
              ),
              AppButton(
                label: 'Outline',
                variant: AppButtonVariant.outline,
                onPressed: () {},
              ),
              AppButton(
                label: 'Continue with Google',
                variant: AppButtonVariant.social,
                leading: const Icon(Icons.g_mobiledata),
                onPressed: () {},
              ),
              AppButton(
                label: 'Text',
                variant: AppButtonVariant.text,
                onPressed: () {},
              ),
              const AppButton(
                label: 'Disabled outline',
                variant: AppButtonVariant.outline,
              ),
            ],
          ),
          const _Section(
            title: 'Text fields',
            children: [
              AppTextField(
                label: 'Email',
                hint: 'you@example.com',
                prefixIcon: Icon(Icons.mail_outline),
                keyboardType: TextInputType.emailAddress,
              ),
              AppTextField(
                label: 'Password',
                hint: 'At least 8 characters',
                prefixIcon: Icon(Icons.lock_outline),
                obscureText: true,
              ),
              AppTextField(
                label: 'With error',
                errorText: 'This field is required',
              ),
            ],
          ),
          _Section(
            title: 'Selection',
            children: [
              AppTabs(
                tabs: const ['Active', 'Completed', 'Saved'],
                selectedIndex: _tab,
                onChanged: (i) => setState(() => _tab = i),
              ),
              AppChips(
                options: const ['Vegan', 'Gluten free', 'Keto', 'Quick'],
                selected: _chips,
                layout: AppChipsLayout.wrap,
                onChanged: (next) => setState(() => _chips = next),
              ),
              AppDropdown<String>(
                hint: 'Pick a cuisine',
                value: _cuisine,
                items: const [
                  AppDropdownItem(value: 'vn', label: 'Vietnamese'),
                  AppDropdownItem(value: 'it', label: 'Italian'),
                  AppDropdownItem(value: 'jp', label: 'Japanese'),
                ],
                onChanged: (v) => setState(() => _cuisine = v),
              ),
              AppSelectionList<String>(
                mode: AppSelectionMode.multi,
                selected: _diet,
                items: const [
                  AppSelectionItem(value: 'Balanced', label: 'Balanced'),
                  AppSelectionItem(value: 'High protein', label: 'High protein'),
                  AppSelectionItem(value: 'Low carb', label: 'Low carb'),
                ],
                onChanged: (next) => setState(() => _diet = next),
              ),
              AppRadioGroup<int>(
                value: _servings,
                items: const [
                  AppRadioGroupItem(value: 1, label: '1 serving'),
                  AppRadioGroupItem(value: 2, label: '2 servings'),
                  AppRadioGroupItem(value: 4, label: '4 servings'),
                ],
                onChanged: (v) => setState(() => _servings = v),
              ),
              AppCheckbox(
                value: _agreed,
                onChanged: (v) => setState(() => _agreed = v),
                child: AppLinkText(
                  spans: [
                    const AppTextSpan(text: 'I agree to the '),
                    AppTextSpan(text: 'Terms', onTap: () {}),
                  ],
                ),
              ),
              Row(
                children: [
                  const Expanded(child: AppText('Notifications')),
                  AppSwitch(
                    value: _notify,
                    onChanged: (v) => setState(() => _notify = v),
                  ),
                ],
              ),
              AppSlider(
                value: _spice,
                onChanged: (v) => setState(() => _spice = v),
              ),
              Center(
                child: AppPageIndicator(
                  count: 4,
                  index: _page,
                  onChanged: (i) => setState(() => _page = i),
                ),
              ),
            ],
          ),
          _Section(
            title: 'Surfaces',
            children: [
              AppCard(
                onTap: () {},
                child: const AppText(
                  'Tap me — an AppCard with ripple.',
                ),
              ),
              const SizedBox(height: 48, child: AppLoading()),
              AppButton(
                label: 'Show dialog',
                variant: AppButtonVariant.soft,
                onPressed: () => AppDialog.show<void>(
                  context: context,
                  title: 'Recipe saved',
                  body: 'You can find it in your library.',
                  actions: AppButton(
                    label: 'OK',
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ),
              AppButton(
                label: 'Show bottom sheet',
                variant: AppButtonVariant.soft,
                onPressed: () => AppBottomSheet.show<void>(
                  context: context,
                  child: const Padding(
                    padding: EdgeInsets.all(AppSpacing.lg),
                    child: AppText('Bottom sheet content'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppText(title, variant: AppTextVariant.title),
          const SizedBox(height: AppSpacing.gap12),
          for (final child in children) ...[
            child,
            const SizedBox(height: AppSpacing.gap12),
          ],
        ],
      ),
    );
  }
}
