part of '../flutter_quran_screen.dart';

class SurahHeaderWidget extends StatelessWidget {
  const SurahHeaderWidget(this.surahName, {super.key});

  final String surahName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(context: context, builder: (ctx) =>
            Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              elevation: 3,
              backgroundColor: const Color(0xFFF7EFE0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('هنا هيبقي موجود معلومات عن السورة وكده')
                    ],
                  ),
                ),
              ),
            ));
      },
      child: Container(
        height: 50,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.symmetric(vertical: 0.0),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Images().surahHeader), fit: BoxFit.fill),
        ),
        alignment: Alignment.center,
        child: Text(
          'سورة $surahName',
          style: FlutterQuran()
              .hafsStyle
              .copyWith(fontWeight: FontWeight.w600, fontSize: 20),
        ),
      ),
    );
  }
}
