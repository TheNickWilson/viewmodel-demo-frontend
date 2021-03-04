#!/bin/bash

echo ""
echo "Applying migration OptionsExample"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /optionsExample                        controllers.OptionsExampleController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /optionsExample                        controllers.OptionsExampleController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeOptionsExample                  controllers.OptionsExampleController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeOptionsExample                  controllers.OptionsExampleController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "optionsExample.title = OptionsExample" >> ../conf/messages.en
echo "optionsExample.heading = OptionsExample" >> ../conf/messages.en
echo "optionsExample.option1 = Option1" >> ../conf/messages.en
echo "optionsExample.option2 = Option2" >> ../conf/messages.en
echo "optionsExample.checkYourAnswersLabel = OptionsExample" >> ../conf/messages.en
echo "optionsExample.error.required = Select optionsExample" >> ../conf/messages.en
echo "optionsExample.change.hidden = OptionsExample" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryOptionsExampleUserAnswersEntry: Arbitrary[(OptionsExamplePage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[OptionsExamplePage.type]";\
    print "        value <- arbitrary[OptionsExample].map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryOptionsExamplePage: Arbitrary[OptionsExamplePage.type] =";\
    print "    Arbitrary(OptionsExamplePage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to ModelGenerators"
awk '/trait ModelGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryOptionsExample: Arbitrary[OptionsExample] =";\
    print "    Arbitrary {";\
    print "      Gen.oneOf(OptionsExample.values.toSeq)";\
    print "    }";\
    next }1' ../test/generators/ModelGenerators.scala > tmp && mv tmp ../test/generators/ModelGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(OptionsExamplePage.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Migration OptionsExample completed"
