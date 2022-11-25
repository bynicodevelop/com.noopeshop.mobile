import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:form_field_validator/form_field_validator.dart";
import "package:shop/utils/translate.dart";

import "../../../../constants.dart";

class ReviewForm extends StatefulWidget {
  final Function(String, bool) onSubmit;

  const ReviewForm({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _reviewController = TextEditingController();

  bool _isRecommend = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t(context)!.review_form_comment_label,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          const SizedBox(height: defaultPadding),
          TextFormField(
            controller: _reviewController,
            onSaved: (review) {},
            validator: RequiredValidator(
              errorText: t(context)!.review_form_comment_required_label,
            ),
            maxLines: 5,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              hintText: t(context)!.review_form_comment_placeholder_label,
            ),
          ),
          const SizedBox(
            height: defaultPadding / 4,
          ),
          Text(
            t(context)!.review_form_comment_help_label,
            style: Theme.of(context).textTheme.overline!.copyWith(
                  color: Theme.of(context).textTheme.bodyText2!.color,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: defaultPadding,
            ),
            child: Divider(),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  t(context)!.review_form_recommand_label,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
              const SizedBox(
                width: defaultPadding,
              ),
              CupertinoSwitch(
                onChanged: (value) => setState(() => _isRecommend = value),
                activeColor: primaryMaterialColor.shade900,
                value: _isRecommend,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: defaultPadding * 1.5,
              bottom: defaultPadding,
            ),
            child: ElevatedButton(
              onPressed: () async {
                // Validate the form field
                if (_formKey.currentState!.validate()) {
                  widget.onSubmit(
                    _reviewController.text,
                    _isRecommend,
                  );
                }
              },
              child: Text(t(context)!.review_form_sumbit_label),
            ),
          )
        ],
      ),
    );
  }
}
