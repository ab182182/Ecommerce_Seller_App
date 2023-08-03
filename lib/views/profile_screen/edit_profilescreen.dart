import 'dart:io';

import 'package:get/get.dart';
import 'package:project_seller/const/const.dart';
import 'package:project_seller/controllers/profile_controller.dart';
import 'package:project_seller/views/widgets/custom_textfield.dart';
import 'package:project_seller/views/widgets/loading_indicator.dart';

import '../widgets/text_style.dart';

class EditProfileScreen extends StatefulWidget {
  final String? username;
  const EditProfileScreen({Key? key, this.username}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  var controller = Get.find<ProfileController>();

  @override
  void initState(){
    super.initState();
    controller.nameController.text = widget.username!;
  }
  @override
  Widget build(BuildContext context) {

    return Obx(
      ()=> Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(text: editProfile, size: 16.0),
          actions: [
            controller.isLoading.value ? loadingIndicator(circleColor: white) : TextButton(onPressed: () async {
              controller.isLoading(true);

              if(controller.profileImgPath.value.isNotEmpty){
                await controller.uploadProfileImage();
              }else{
                controller.profileImageLink = controller.snapshotData['imageUrl'];
              }

              if(controller.snapshotData['password'] == controller.oldPassController.text){
                await controller.changeAuthPassword(
                  email: controller.snapshotData['email'],
                  password: controller.oldPassController.text,
                  newPassword: controller.newPassController.text
                );

                await controller.updateProfile(
                  imgUrl: controller.profileImageLink,
                  name: controller.nameController.text,
                  password: controller.newPassController.text
                );
                VxToast.show(context, msg: "Updated");

              }else if(controller.oldPassController.text.isEmptyOrNull && controller.newPassController.text.isEmptyOrNull){
                await controller.updateProfile(
                    imgUrl: controller.profileImageLink,
                    name: controller.nameController.text,
                    password: controller.snapshotData['password']
                );
              } else {
                VxToast.show(context, msg: "Some error occured");
                controller.isLoading(false);
              }

            }, child: normalText(text: save)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child:
                Column(
                children: [
                  controller.snapshotData['imageUrl'] == '' && controller.profileImgPath.isEmpty
                      ? Image.asset(imgProduct,
                      width: 100, fit: BoxFit.cover)
                      .box
                      .roundedFull
                      .clip(Clip.antiAlias)
                      .make()
                      : controller.snapshotData['imageUrl'] != '' &&
                      controller.profileImgPath.isEmpty
                      ? Image.network(
                    controller.snapshotData['imageUrl'],
                    width: 100,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make()
                      : Image.file(
                    File(controller.profileImgPath.value),
                    width: 100,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make(),
                  // Image.asset(
                  //   imgProduct,
                  //   width: 150,
                  // ).box.roundedFull.clip(Clip.antiAlias).make(),
                  10.heightBox,
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: white,
                      ),
                      onPressed: () {
                        controller.changeImage(context);
                      },
                      child: normalText(text: changeImage, color: fontGrey)),
                  10.heightBox,
                  const Divider(color: white,),
                  customTextField(label: name, hint: "eg. Saumya Designer",controller: controller.nameController),
                  30.heightBox,
                  Align(alignment: Alignment.centerLeft, child: boldText(text: "Change Password")),
                  10.heightBox,
                  customTextField(label: password,hint: passwordHint,controller: controller.oldPassController),
                  10.heightBox,
                  customTextField(label: confirmPass,hint: passwordHint,controller: controller.newPassController),
                ],
              ),

          ),
        ),
      ),
    );
  }
}
