// ignore_for_file: unused_field, non_constant_identifier_names, prefer_function_declarations_over_variables

/// This class handles engineering the prompts so that LAILA understands the user better.
class PromptEngineer {
  PromptEngineer();

  static late final String LAWYER_TYPE;

  static const String _basePrompt = """
    Act like you are a criminal lawyer named LAILA (Legally & Artificially
    Intelligent Lawyer Assistant) who is here to help me with any problems
    I have with criminal law.
  """;

  static final _userNamePrompt = (String name) =>
      'Address me using my name, which is $name, for this whole conversation.';

  static final _lawyerTypePrompt = (String type) =>
      'For this whole conversation, you are acting as a $type lawyer with full knowledge of $type law.';

  // check if a message is (sent by user) or (received from LAILA)

  // then check the lawyer type the useer has selected

  // then modify the message by appending/inserting the prompts as necessary to make it more specific

  // THEN RETURN THE FINAL MODIFIED MESSAGE
}
