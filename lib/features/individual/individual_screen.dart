import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truyen_cv/bloc/bloc_provider.dart';
import 'package:truyen_cv/i18n/strings.g.dart';
import 'package:truyen_cv/shared/utilities/device.dart';

class IndividualScreen extends ConsumerStatefulWidget {
  const IndividualScreen({super.key});

  @override
  ConsumerState<IndividualScreen> createState() => _IndividualScreenState();
}

class _IndividualScreenState extends ConsumerState<IndividualScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = ref.watch(BlocProvider.individual);
    const bool isLoggedIn = true;
    final t = context.t;
    final isTablet = MediaQuery.of(context).size.width > 600;
    final double indentValue = isTablet ? 24.0 : 16.0;

    final double paddingTop = MediaQuery.of(context).padding.top;
    final double minHeaderExtent = kToolbarHeight + paddingTop;
    // Adaptive header height based on screen width
    final double screenWidth = MediaQuery.of(context).size.width;
    final double maxHeaderExtent = screenWidth > 600 ? 320.0 : 280.0;

    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollEndNotification &&
              notification.depth == 0) {
            _onScrollEnd(
              _scrollController.position.pixels,
              minHeaderExtent,
              maxHeaderExtent,
            );
          }
          return false;
        },
        child: CustomScrollView(
          controller: _scrollController,
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: _ProfileHeaderDelegate(
                minHeaderExtent: minHeaderExtent,
                maxHeaderExtent: maxHeaderExtent,
                paddingTop: paddingTop,
                isLoggedIn: isLoggedIn,
                t: t,
                onLogout: () {},
              ),
            ),
            SliverToBoxAdapter(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      maxHeaderExtent +
                      minHeaderExtent,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildSectionTitle(context, t.individual.data),
                    _buildMenuItem(
                      context,
                      icon: Icons.cloud_sync_outlined,
                      title: t.individual.syncBackup,
                      subtitle: t.individual.cloudStorage,
                      onTap: bloc.onTapBackup,
                    ),
                    Divider(
                      height: 32,
                      thickness: 1,
                      indent: indentValue,
                      endIndent: indentValue,
                    ),
                    _buildSocialMediaSection(context),
                    Divider(
                      height: 32,
                      thickness: 1,
                      indent: indentValue,
                      endIndent: indentValue,
                    ),
                    _buildSectionTitle(context, t.individual.system),
                    _buildMenuItem(
                      context,
                      icon: Icons.settings_outlined,
                      title: t.individual.settings,
                      onTap: bloc.onTapSetting,
                    ),
                    FutureBuilder<String>(
                      future: DeviceUtil.getFullVersion(),
                      builder: (context, snapshot) {
                        final String versionText = snapshot.hasData
                            ? '${t.individual.appVersion} ${snapshot.data}'
                            : t.individual.loading;
                        return Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Text(
                            versionText,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
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
          ],
        ),
      ),
    );
  }

  void _onScrollEnd(
    double pixels,
    double minExtent,
    double maxExtent,
  ) {
    if (!_scrollController.hasClients) return;

    // Kiểm tra nếu đã scroll đến cuối cùng, không snap nữa
    final maxScrollExtent = _scrollController.position.maxScrollExtent;
    if (pixels >= maxScrollExtent - 10) {
      // Đã ở gần cuối cùng, để người dùng scroll tự do
      return;
    }

    final scrollAmount = maxExtent - minExtent;
    final snapThreshold = scrollAmount / 2;

    // Chỉ snap nếu scroll position còn trong header range
    if (pixels >= scrollAmount) {
      // Đã scroll qua header, không snap
      return;
    }

    final targetOffset = pixels < snapThreshold ? 0.0 : scrollAmount;

    Future.microtask(() {
      _scrollController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
    });
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    return Padding(
      padding: EdgeInsets.only(
        left: isTablet ? 24 : 16,
        bottom: 8,
        top: 8,
        right: isTablet ? 24 : 16,
      ),
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
    final isTablet = MediaQuery.of(context).size.width > 600;
    return ListTile(
      leading:
          Icon(icon, color: Theme.of(context).colorScheme.primary, size: 22),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(
                fontSize: isTablet ? 13 : 12,
              ),
            )
          : null,
      trailing: trailing ??
          Icon(
            Icons.chevron_right,
            color: Theme.of(context).colorScheme.outline,
          ),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(
        horizontal: isTablet ? 24 : 16,
        vertical: 4,
      ),
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
    final isTablet = size.width > 600;

    // 1. Tính toán phần trăm (0.0 -> 1.0)
    final double percent =
        (shrinkOffset / (maxHeaderExtent - minHeaderExtent)).clamp(0.0, 1.0);

    // 2. Cấu hình kích thước Avatar (responsive)
    final double maxImageSize = isTablet ? 120.0 : 90.0;
    final double minImageSize = 40.0;
    final double currentImageSize =
        (maxImageSize * (1 - percent)).clamp(minImageSize, maxImageSize);

    // 3. Cấu hình Vị trí Avatar (Left) - responsive
    final double maxLeftMargin = size.width / 2 - maxImageSize / 2;
    final double minLeftMargin = isTablet ? 24.0 : 16.0;
    final double currentLeft =
        minLeftMargin + (maxLeftMargin - minLeftMargin) * (1 - percent);

    // 4. Cấu hình Vị trí Avatar (Bottom) - responsive
    final double maxBottomMargin = maxHeaderExtent * 0.35;
    final double minBottomMargin = (kToolbarHeight - minImageSize) / 2 + 2;
    final double currentBottom =
        minBottomMargin + (maxBottomMargin - minBottomMargin) * (1 - percent);

    // 5. Tính toán responsive spacing cho text
    final double textBottomSpacing =
        maxBottomMargin - (maxImageSize * 0.6) - (isTablet ? 20 : 10);

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        children: [
          // A. TEXT INFO (Tên to & Email) - Mờ dần khi cuộn lên
          Positioned(
            left: 0,
            right: 0,
            bottom: textBottomSpacing,
            child: Opacity(
              opacity: (1 - percent * 1.5).clamp(0.0, 1.0),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: isTablet ? 32 : 16),
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
          ),

          // B. SMALL TITLE (Tên nhỏ trên AppBar) - Hiện dần khi cuộn lên
          Positioned(
            left: minLeftMargin + minImageSize + 12,
            bottom: 0,
            top: paddingTop,
            right: (isTablet ? 80 : 60),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Opacity(
                opacity: percent,
                child: Text(
                  isLoggedIn ? 'Nguyễn Văn A' : t.individual.individual,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: isTablet ? 20 : 18,
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
