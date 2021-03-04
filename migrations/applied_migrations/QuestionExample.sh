#!/bin/bash

echo ""
echo "Applying migration QuestionExample"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /questionExample                        controllers.QuestionExampleController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /questionExample                        controllers.QuestionExampleController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeQuestionExample                  controllers.QuestionExampleController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeQuestionExample                  controllers.QuestionExampleController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "questionExample.title = questionExample" >> ../conf/messages.en
echo "questionExample.heading = questionExample" >> ../conf/messages.en
echo "questionExample.field1 = field1" >> ../conf/messages.en
echo "questionExample.field2 = field2" >> ../conf/messages.en
echo "questionExample.checkYourAnswersLabel = QuestionExample" >> ../conf/messages.en
echo "questionExample.error.field1.required = Enter field1" >> ../conf/messages.en
echo "questionExample.error.field2.required = Enter field2" >> ../conf/messages.en
echo "questionExample.error.field1.length = field1 must be 100 characters or less" >> ../conf/messages.en
echo "questionExample.error.field2.length = field2 must be 100 characters or less" >> ../conf/messages.en
echo "questionExample.field1.change.hidden = field1" >> ../conf/messages.en
echo "questionExample.field2.change.hidden = field2" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryQuestionExampleUserAnswersEntry: Arbitrary[(QuestionExamplePage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[QuestionExamplePage.type]";\
    print "        value <- arbitrary[QuestionExample].map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryQuestionExamplePage: Arbitrary[QuestionExamplePage.type] =";\
    print "    Arbitrary(QuestionExamplePage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to ModelGenerators"
awk '/trait ModelGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryQuestionExample: Arbitrary[QuestionExample] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        field1 <- arbitrary[String]";\
    print "        field2 <- arbitrary[String]";\
    print "      } yield QuestionExample(field1, field2)";\
    print "    }";\
    next }1' ../test/generators/ModelGenerators.scala > tmp && mv tmp ../test/generators/ModelGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(QuestionExamplePage.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Migration QuestionExample completed"
