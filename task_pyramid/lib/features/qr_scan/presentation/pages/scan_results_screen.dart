import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_pyramid/features/auth/presentation/widgets/submit_button_widget.dart';
import 'package:task_pyramid/features/qr_scan/presentation/pages/scan_screen.dart';

import '../../../../core/constant/constant.dart';
import '../widgets/arrrival_item_widget.dart';
import '../cubit/qr_code_cubit.dart';

class ScanResultsScreen extends StatefulWidget {
  const ScanResultsScreen({Key? key}) : super(key: key);

  @override
  State<ScanResultsScreen> createState() => _ScanResultsScreenState();
}

class _ScanResultsScreenState extends State<ScanResultsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<QrCodeCubit>().fGetScanResults();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          margin: const EdgeInsets.only(
            top: 100,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: ()=>Constant.pushReplacment(
                    context, const QrCodeScreen()),
                child: Container(
                    margin: Constant.kPaddingA8,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Constant.primaryColor, width: 3),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(05))),
                    child: Icon(Icons.skip_previous_outlined,
                        color: Constant.primaryColor)),
              ),
              Container(
                  margin: Constant.kMargin16,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        "Scan Results",
                        textAlign: TextAlign.center,
                        style: Constant.bodyText16,
                      ),
                      const SizedBox(height: 20,),
                      const Text(
                        "Proreader will keep your last 10 day history Proreader will keep your last 10 day history Proreader will keep your last 10 day history ",
                        textAlign: TextAlign.center,
                        softWrap: true,
                      )
                    ],
                  )),
              Expanded(
                child: BlocBuilder<QrCodeCubit, ScanResultsState>(
                    builder: (context, state) {
                  final scanResults = context.watch<QrCodeCubit>().scanResults;
                  return Padding(
                      padding: Constant.kPaddingH8,
                      child: ListView.builder(
                          controller: _scrollController,
                          itemCount: scanResults.length,
                          itemBuilder: (context, index) {
                            // if (index == scanResults.length) {
                            //   if (state is ScanResultsLoadingMore) {
                            //     return const LazyLoading();
                            //   } else {
                            //     return const SizedBox();
                            //   }
                            // }
                            return ScanResultsItem(text: scanResults[index]);
                          }));
                }),
              ),
              SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: SubmitButton(
                    function: () {},
                    title: "Send",
                  )),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ));
  }
}
