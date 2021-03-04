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

package viewmodels.govuk

import play.api.i18n.Messages
import uk.gov.hmrc.govukfrontend.views.viewmodels.content.{HtmlContent, Text}
import uk.gov.hmrc.govukfrontend.views.viewmodels.phasebanner.PhaseBanner

trait PhaseBannerFluency extends TagFluency {

  object PhaseBannerViewModel {

    def apply(
               phase: Phase,
               feedbackUrl: String
             )(implicit messages: Messages): PhaseBanner = {

      val link = s"""<a class="govuk-link" href="${feedbackUrl}">${messages("phase.feedback.link")}</a>"""
      val content = s"${messages("phase.feedback.before")} $link ${messages("phase.feedback.after")}"

      val tag =
        TagViewModel(Text(phase.toString))
          .withCssClass("govuk-phase-banner__content__tag")

      PhaseBanner(
        tag = Some(tag),
        content = HtmlContent(content)
      )
    }
  }
}
