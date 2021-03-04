#!/bin/bash

echo ""
echo "Applying migration IntExample"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /intExample                  controllers.IntExampleController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /intExample                  controllers.IntExampleController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeIntExample                        controllers.IntExampleController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeIntExample                        controllers.IntExampleController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "intExample.title = IntExample" >> ../conf/messages.en
echo "intExample.heading = IntExample" >> ../conf/messages.en
echo "intExample.checkYourAnswersLabel = IntExample" >> ../conf/messages.en
echo "intExample.error.nonNumeric = Enter your intExample using numbers" >> ../conf/messages.en
echo "intExample.error.required = Enter your intExample" >> ../conf/messages.en
echo "intExample.error.wholeNumber = Enter your intExample using whole numbers" >> ../conf/messages.en
echo "intExample.error.outOfRange = IntExample must be between {0} and {1}" >> ../conf/messages.en
echo "intExample.change.hidden = IntExample" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryIntExampleUserAnswersEntry: Arbitrary[(IntExamplePage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[IntExamplePage.type]";\
    print "        value <- arbitrary[Int].map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryIntExamplePage: Arbitrary[IntExamplePage.type] =";\
    print "    Arbitrary(IntExamplePage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(IntExamplePage.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Migration IntExample completed"
