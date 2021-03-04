/*
 * Copyright 2021 HM Revenue & Customs
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package generators

import models._
import org.scalacheck.Arbitrary
import org.scalacheck.Arbitrary.arbitrary
import pages._
import play.api.libs.json.{JsValue, Json}

trait UserAnswersEntryGenerators extends PageGenerators with ModelGenerators {

  implicit lazy val arbitraryYesNoExampleUserAnswersEntry: Arbitrary[(YesNoExamplePage.type, JsValue)] =
    Arbitrary {
      for {
        page  <- arbitrary[YesNoExamplePage.type]
        value <- arbitrary[Boolean].map(Json.toJson(_))
      } yield (page, value)
    }

  implicit lazy val arbitraryStringExampleUserAnswersEntry: Arbitrary[(StringExamplePage.type, JsValue)] =
    Arbitrary {
      for {
        page  <- arbitrary[StringExamplePage.type]
        value <- arbitrary[String].suchThat(_.nonEmpty).map(Json.toJson(_))
      } yield (page, value)
    }

  implicit lazy val arbitraryQuestionExampleUserAnswersEntry: Arbitrary[(QuestionExamplePage.type, JsValue)] =
    Arbitrary {
      for {
        page  <- arbitrary[QuestionExamplePage.type]
        value <- arbitrary[QuestionExample].map(Json.toJson(_))
      } yield (page, value)
    }

  implicit lazy val arbitraryOptionsExampleUserAnswersEntry: Arbitrary[(OptionsExamplePage.type, JsValue)] =
    Arbitrary {
      for {
        page  <- arbitrary[OptionsExamplePage.type]
        value <- arbitrary[OptionsExample].map(Json.toJson(_))
      } yield (page, value)
    }

  implicit lazy val arbitraryIntExampleUserAnswersEntry: Arbitrary[(IntExamplePage.type, JsValue)] =
    Arbitrary {
      for {
        page  <- arbitrary[IntExamplePage.type]
        value <- arbitrary[Int].map(Json.toJson(_))
      } yield (page, value)
    }

  implicit lazy val arbitraryDateExampleUserAnswersEntry: Arbitrary[(DateExamplePage.type, JsValue)] =
    Arbitrary {
      for {
        page  <- arbitrary[DateExamplePage.type]
        value <- arbitrary[Int].map(Json.toJson(_))
      } yield (page, value)
    }

  implicit lazy val arbitraryCheckboxExampleUserAnswersEntry: Arbitrary[(CheckboxExamplePage.type, JsValue)] =
    Arbitrary {
      for {
        page  <- arbitrary[CheckboxExamplePage.type]
        value <- arbitrary[CheckboxExample].map(Json.toJson(_))
      } yield (page, value)
    }
}
