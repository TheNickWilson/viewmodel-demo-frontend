#!/bin/bash

echo ""
echo "Applying migration DateExample"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /dateExample                  controllers.DateExampleController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /dateExample                  controllers.DateExampleController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeDateExample                        controllers.DateExampleController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeDateExample                        controllers.DateExampleController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "dateExample.title = DateExample" >> ../conf/messages.en
echo "dateExample.heading = DateExample" >> ../conf/messages.en
echo "dateExample.hint = For example, 12 11 2007" >> ../conf/messages.en
echo "dateExample.checkYourAnswersLabel = DateExample" >> ../conf/messages.en
echo "dateExample.error.required.all = Enter the dateExample" >> ../conf/messages.en
echo "dateExample.error.required.two = The dateExample" must include {0} and {1} >> ../conf/messages.en
echo "dateExample.error.required = The dateExample must include {0}" >> ../conf/messages.en
echo "dateExample.error.invalid = Enter a real DateExample" >> ../conf/messages.en
echo "dateExample.change.hidden = DateExample" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryDateExampleUserAnswersEntry: Arbitrary[(DateExamplePage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[DateExamplePage.type]";\
    print "        value <- arbitrary[Int].map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryDateExamplePage: Arbitrary[DateExamplePage.type] =";\
    print "    Arbitrary(DateExamplePage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(DateExamplePage.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Migration DateExample completed"
