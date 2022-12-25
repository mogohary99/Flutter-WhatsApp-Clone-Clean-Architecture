import 'package:flutter/cupertino.dart';
import 'package:giphy_get/giphy_get.dart';

abstract class BaseChatLocalDataSource{
  Future<GiphyGif?> pickGif(BuildContext context);
}

class ChatLocalDataSource extends BaseChatLocalDataSource{
  @override
  Future<GiphyGif?> pickGif(BuildContext context)async {
    GiphyGif? gif;
      gif = await GiphyGet.getGif(
        context: context,
        apiKey: 'GmpyPrPF9RVZ1LJY1iAe6O8MTWrBpNob',

      );
      return gif;
  }

}