import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/i18n/strings.g.dart';
import 'package:flutter_template/shared/utilities/device.dart';

class IndividualScreen extends ConsumerWidget {
  const IndividualScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final bloc = ref.watch(BlocProvider.individual);
    const bool isLoggedIn = false;
    final t = context.t;

    final double paddingTop = MediaQuery.of(context).padding.top;
    final double minHeaderExtent = kToolbarHeight + paddingTop;
    const double maxHeaderExtent = 280.0;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverPersistentHeader(
              pinned: true,
              delegate: _ProfileHeaderDelegate(
                minHeaderExtent: minHeaderExtent,
                maxHeaderExtent: maxHeaderExtent,
                paddingTop: paddingTop,
                isLoggedIn: isLoggedIn,
                t: t,
                onLogout: () {
                  // Handle Logout
                },
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          padding: EdgeInsets.zero,
          physics: const ClampingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSectionTitle(context, t.individual.data),
              _buildMenuItem(
                context,
                icon: Icons.cloud_sync_outlined,
                title: t.individual.syncBackup,
                subtitle: t.individual.cloudStorage,
                onTap: () {},
              ),
              const Divider(
                height: 32,
                thickness: 1,
                indent: 16,
                endIndent: 16,
              ),
              _buildSocialMediaSection(context),
              const Divider(
                height: 32,
                thickness: 1,
                indent: 16,
                endIndent: 16,
              ),
              _buildSectionTitle(context, t.individual.system),
              _buildMenuItem(
                context,
                icon: Icons.settings_outlined,
                title: t.individual.settings,
                onTap: bloc.onTapSetting,
              ),
              if (isLoggedIn)
                _buildMenuItem(
                  context,
                  icon: Icons.logout_outlined,
                  title: t.individual.logout,
                  onTap: () {},
                ),
              FutureBuilder<String>(
                future: Device.getVersion(),
                builder: (context, snapshot) {
                  final String versionText = snapshot.hasData
                      ? '${t.individual.appVersion} ${snapshot.data}'
                      : t.individual.loading;
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      versionText,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8, top: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title.toUpperCase(),
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading:
          Icon(icon, color: Theme.of(context).colorScheme.primary, size: 22),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: subtitle != null
          ? Text(subtitle, style: const TextStyle(fontSize: 12))
          : null,
      trailing: trailing ??
          Icon(
            Icons.chevron_right,
            color: Theme.of(context).colorScheme.outline,
          ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  Widget _buildSocialMediaSection(BuildContext context) {
    final t = context.t;
    return Column(
      children: [
        _buildSectionTitle(context, t.individual.socialNetworkConnection),
        _buildMenuItem(
          context,
          icon: Icons.facebook,
          title: 'Facebook',
          subtitle: t.individual.connectWithFacebook,
          onTap: () {},
        ),
        _buildMenuItem(
          context,
          icon: Icons.link,
          title: t.individual.personalWebsite,
          subtitle: t.individual.visitPersonalWebsite,
          onTap: () {},
        ),
        _buildMenuItem(
          context,
          icon: Icons.alternate_email,
          title: 'Twitter',
          subtitle: t.individual.followOnTwitter,
          onTap: () {},
        ),
      ],
    );
  }
}

class _ProfileHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeaderExtent;
  final double maxHeaderExtent;
  final double paddingTop;
  final bool isLoggedIn;
  final dynamic t;
  final VoidCallback onLogout;

  _ProfileHeaderDelegate({
    required this.minHeaderExtent,
    required this.maxHeaderExtent,
    required this.paddingTop,
    required this.isLoggedIn,
    required this.t,
    required this.onLogout,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;

    // 1. Tính toán phần trăm (0.0 -> 1.0)
    // Công thức này chuẩn hơn: đảm bảo percent chạy từ 0 đến 1 khớp với quá trình cuộn
    final double percent =
        (shrinkOffset / (maxHeaderExtent - minHeaderExtent)).clamp(0.0, 1.0);

    // 2. Cấu hình kích thước Avatar
    const double maxImageSize = 90.0;
    const double minImageSize = 40.0;
    // Nội suy kích thước
    final double currentImageSize =
        (maxImageSize * (1 - percent)).clamp(minImageSize, maxImageSize);

    // 3. Cấu hình Vị trí Avatar (Left)
    // - Khi mở rộng (max): Nằm giữa màn hình
    final double maxLeftMargin = size.width / 2 - maxImageSize / 2;
    // - Khi thu nhỏ (min): Cách lề trái 16px
    const double minLeftMargin = 16.0;
    // Nội suy vị trí trái
    final double currentLeft =
        minLeftMargin + (maxLeftMargin - minLeftMargin) * (1 - percent);

    // 4. Cấu hình Vị trí Avatar (Bottom)
    // - Khi mở rộng: Nằm cao hơn text một chút
    final double maxBottomMargin =
        maxHeaderExtent * 0.35; // Tùy chỉnh số này để nâng hạ avatar lúc to
    // - Khi thu nhỏ: Căn giữa theo chiều dọc của Toolbar (Toolbar height = 56)
    final double minBottomMargin =
        (kToolbarHeight - minImageSize) / 2 + 2; // +2 để cân chỉnh visual
    // Nội suy vị trí dưới
    final double currentBottom =
        minBottomMargin + (maxBottomMargin - minBottomMargin) * (1 - percent);

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        children: [
          // A. TEXT INFO (Tên to & Email) - Mờ dần khi cuộn lên
          Positioned(
            left: 0,
            right: 0,
            // Text nằm dưới avatar lúc to
            bottom: maxBottomMargin - 60,
            child: Opacity(
              opacity: (1 - percent * 1.5).clamp(0.0, 1.0), // Mờ nhanh hơn chút
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isLoggedIn ? 'Nguyễn Văn A' : t.individual.notLoggedIn,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isLoggedIn
                        ? 'nguyenvana@gmail.com'
                        : t.individual.tapToLoginOrRegister,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
          ),

          // B. SMALL TITLE (Tên nhỏ trên AppBar) - Hiện dần khi cuộn lên
          Positioned(
            left: minLeftMargin + minImageSize + 12, // Né cái avatar nhỏ ra
            bottom: 0,
            top: paddingTop, // Căn giữa Toolbar
            right: 60, // Né nút logout
            child: Align(
              alignment: Alignment.centerLeft,
              child: Opacity(
                opacity: percent, // Hiện theo percent
                child: Text(
                  isLoggedIn ? 'Nguyễn Văn A' : t.individual.individual,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),

          // C. AVATAR (Di chuyển theo tính toán)
          Positioned(
            left: currentLeft,
            bottom: currentBottom,
            child: Container(
              width: currentImageSize,
              height: currentImageSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.surfaceContainerHighest,
                image: isLoggedIn
                    ? const DecorationImage(
                        image: NetworkImage('https://i.pravatar.cc/150?img=12'),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: !isLoggedIn
                  ? Icon(
                      Icons.person,
                      size: currentImageSize * 0.6,
                      color: colorScheme.onSurfaceVariant,
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => maxHeaderExtent;

  @override
  double get minExtent => minHeaderExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true; // Rebuild khi theme hoặc data thay đổi
  }
}
