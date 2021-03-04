#!/bin/bash

echo ""
echo "Applying migration CheckboxExample"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /checkboxExample                        controllers.CheckboxExampleController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /checkboxExample                        controllers.CheckboxExampleController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeCheckboxExample                  controllers.CheckboxExampleController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeCheckboxExample                  controllers.CheckboxExampleController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "checkboxExample.title = CheckboxExample" >> ../conf/messages.en
echo "checkboxExample.heading = CheckboxExample" >> ../conf/messages.en
echo "checkboxExample.option1 = Option1" >> ../conf/messages.en
echo "checkboxExample.option2 = Option2" >> ../conf/messages.en
echo "checkboxExample.checkYourAnswersLabel = CheckboxExample" >> ../conf/messages.en
echo "checkboxExample.error.required = Select checkboxExample" >> ../conf/messages.en
echo "checkboxExample.change.hidden = CheckboxExample" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryCheckboxExampleUserAnswersEntry: Arbitrary[(CheckboxExamplePage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[CheckboxExamplePage.type]";\
    print "        value <- arbitrary[CheckboxExample].map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryCheckboxExamplePage: Arbitrary[CheckboxExamplePage.type] =";\
    print "    Arbitrary(CheckboxExamplePage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to ModelGenerators"
awk '/trait ModelGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryCheckboxExample: Arbitrary[CheckboxExample] =";\
    print "    Arbitrary {";\
    print "      Gen.oneOf(CheckboxExample.values)";\
    print "    }";\
    next }1' ../test/generators/ModelGenerators.scala > tmp && mv tmp ../test/generators/ModelGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(CheckboxExamplePage.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Migration CheckboxExample completed"
