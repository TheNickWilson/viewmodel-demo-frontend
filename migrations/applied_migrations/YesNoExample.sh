#!/bin/bash

echo ""
echo "Applying migration YesNoExample"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /yesNoExample                        controllers.YesNoExampleController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /yesNoExample                        controllers.YesNoExampleController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeYesNoExample                  controllers.YesNoExampleController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeYesNoExample                  controllers.YesNoExampleController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "yesNoExample.title = yesNoExample" >> ../conf/messages.en
echo "yesNoExample.heading = yesNoExample" >> ../conf/messages.en
echo "yesNoExample.checkYourAnswersLabel = yesNoExample" >> ../conf/messages.en
echo "yesNoExample.error.required = Select yes if yesNoExample" >> ../conf/messages.en
echo "yesNoExample.change.hidden = YesNoExample" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryYesNoExampleUserAnswersEntry: Arbitrary[(YesNoExamplePage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[YesNoExamplePage.type]";\
    print "        value <- arbitrary[Boolean].map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryYesNoExamplePage: Arbitrary[YesNoExamplePage.type] =";\
    print "    Arbitrary(YesNoExamplePage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(YesNoExamplePage.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Migration YesNoExample completed"
