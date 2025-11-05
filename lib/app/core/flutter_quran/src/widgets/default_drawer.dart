part of '../flutter_quran_screen.dart';

class DefaultDrawer extends StatelessWidget {
  const DefaultDrawer();

  @override
  Widget build(BuildContext context) {
    final jozzs = FlutterQuran().getAllJozzs();
    final hizbs = FlutterQuran().getAllHizbs();
    final surahs = FlutterQuran().getAllSurahs();

    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(height: 40),

            // الفهرس Section
            _buildExpansionSection(
              title: 'الفهرس',
              icon: Icons.menu_book_rounded,
              children: [
                // الأجزاء
                _buildNestedExpansionTile(
                  title: 'الأجزاء',
                  icon: Icons.bookmark_outline_rounded,
                  children: List.generate(
                    jozzs.length,
                        (jozzIndex) =>
                        _buildJozzExpansionTile(
                          jozzs[jozzIndex],
                          jozzIndex,
                          hizbs,
                          context,
                        ),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(height: 20),
                ),

                // السور
                _buildExpansionTile(
                  title: 'السور',
                  icon: Icons.library_books_rounded,
                  children: List.generate(
                    surahs.length,
                        (index) =>
                        _buildSurahTile(
                          surahs[index],
                          index,
                          context,
                        ),
                  ),
                ),
              ],
            ),

            // العلامات Section
            // _buildExpansionSection(
            //   title: 'العلامات',
            //   icon: Icons.bookmark_rounded,
            //   children: [
            //     Column(
            //       children: FlutterQuran()
            //           .getUsedBookmarks()
            //           .map((bookmark) => _buildBookmarkTile(bookmark, context))
            //           .toList(),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.blue[700],
        size: 24,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        color: Colors.grey[600],
        size: 16,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Colors.grey[800],
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _buildExpansionSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        leading: Icon(
          icon,
          color: Colors.green[700],
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.grey[800],
          ),
        ),
        collapsedIconColor: Colors.grey[600],
        iconColor: Colors.green[700],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        tilePadding: const EdgeInsets.symmetric(horizontal: 16),
        childrenPadding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
        children: children,
      ),
    );
  }

  Widget _buildExpansionTile({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return ExpansionTile(
      leading: Icon(icon, size: 20, color: Colors.blue[600]),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
          color: Colors.grey[700],
        ),
      ),
      collapsedIconColor: Colors.grey[500],
      iconColor: Colors.blue[600],
      children: children,
    );
  }

  Widget _buildNestedExpansionTile({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return ExpansionTile(
      leading: Icon(icon, size: 20, color: Colors.blue[600]),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
          color: Colors.grey[700],
        ),
      ),
      collapsedIconColor: Colors.grey[500],
      iconColor: Colors.blue[600],
      children: children,
    );
  }

  Widget _buildJozzExpansionTile(String jozz,
      int jozzIndex,
      List<String> hizbs,
      BuildContext context,) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 2),
      elevation: 0,
      color: Colors.grey[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ExpansionTile(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.green[100],
                shape: BoxShape.circle,
              ),
              child: Text(
                '${jozzIndex + 1}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                jozz,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
        children: List.generate(2, (index) {
          final hizbIndex = (index == 0 && jozzIndex == 0)
              ? 0
              : ((jozzIndex * 2 + index));
          return _buildHizbTile(hizbs[hizbIndex], hizbIndex, context);
        }),
      ),
    );
  }

  Widget _buildHizbTile(String hizb, int hizbIndex, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            shape: BoxShape.circle,
          ),
          child: Text(
            '${hizbIndex + 1}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue[700],
              fontSize: 11,
            ),
          ),
        ),
        title: Text(
          hizb,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.grey[500],
          size: 14,
        ),
        onTap: () {
          FlutterQuran().navigateToHizb(hizbIndex + 1);
          Navigator.of(context).pop();
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        minLeadingWidth: 0,
      ),
    );
  }

  Widget _buildSurahTile(String surah, int index, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.orange[50],
            shape: BoxShape.circle,
          ),
          child: Text(
            '${index + 1}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.orange[700],
              fontSize: 12,
            ),
          ),
        ),
        title: Text(
          surah,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.grey[500],
          size: 14,
        ),
        onTap: () {
          FlutterQuran().navigateToSurah(index + 1);
          Navigator.of(context).pop();
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        minLeadingWidth: 0,
      ),
    );
  }

  Widget _buildBookmarkTile(Bookmark bookmark, BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Color(bookmark.colorCode).withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.bookmark_rounded,
            color: Color(bookmark.colorCode),
            size: 20,
          ),
        ),
        title: Text(
          bookmark.name,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.grey[500],
          size: 14,
        ),
        onTap: () {
          FlutterQuran().navigateToBookmark(bookmark);
          Navigator.of(context).pop();
        },
      ),
    );
  }
}