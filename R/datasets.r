#' A dataset containing survey results on the acceptance of robot care
#'
#' This data set contains the results of a survey from a study on the acceptance of robot care. The data set contains
#' some demographic data, some psychometric measurements, as well as attitude measurements towards both human and robot care.
#' The sample is not representative.
#'
#' @docType data
#'
#' @usage data(robo_care)
#'
#' @format An object of class \code{"tibble"}
#' \describe{
#'  \item{age}{Age of the participant}
#'  \item{gender}{Gender of the participant}
#'  \item{job_type}{Occupational status.}
#'  \item{robo_bed/human_bed}{How willing are you to accept that a robot will bring you to bed (disagree 1-6 agree).}
#'  \item{robo_XXX/human_XXX}{Several measurements about care (being fed, giving medicine, body massage, washing hair, washing the face, lifted onto a toilet)}
#'  \item{diff_pref}{Preference for difficult tasks.}
#'  \item{technical_knowledge}{How well a participant subjectively feels informed about technical things.}
#'  \item{privacy_concerns}{How concerned the person is about privacy.}
#'  \item{cse}{Self-efficacy with regards to computerized systems. Beier (1999)}
#'  \item{automation_tendency}{The tendency to favor automation over manually doing things.}
#'  \item{care_experience}{Has the participant made direct or indirect experience in caring for a person.}
#' }
#' @keywords datasets
#'
#' @references André Calero Valdez (Eds.) (2017) Akzeptanz autonomer Robotik, Apprimus Aachen
#' (\href{https://www.apprimus-verlag.de/akzeptanz-autonomer-robotik.html}{Apprimus})
#'
#' @source Data was self-collected at the RWTH Aachen University.
#'
#'
#' @examples
#' library(ggplot2)
#' \donttest{ggplot(robo_care) + aes(cse, care_pref_robo) +
#'        geom_jitter(width = 0.1, height = 0, alpha = 0.5)}
"robo_care"




#' A dataset containing artificial data to demonstrate variance of analysis visually
#'
#' This data set contains the completely faked data on phone usage. It has nice properties for variance analyses.
#'
#'
#' @docType data
#'
#' @usage data(anova_phone)
#'
#' @format An object of class \code{"data.frame"}
#' \describe{
#'  \item{whatsapp}{How many whatsapp messages a user sends}
#'  \item{textmessage}{How many text messages a users sends}
#'  \item{phone}{What type of phone the user uses.}
#'  \item{user}{The user name.}
#'  \item{gender}{The gender of the user}
#'  \item{age}{The age of the user.}
#' }
#' @keywords datasets
#'
#' @source Data was self generated.
#'
#'
#' @examples
#' library(ggplot2)
#' \donttest{ggplot(anova_phone) + aes(phone, whatsapp, color = phone) +
#'        geom_point()}
"anova_phone"



#' A raw data set that can be used in training for factor analysis
#'
#' The dataset contains variable labels and level labels. Use of the
#' `to_factor` function from the `labelled` package is highly suggested.
#'
#' @docType data
#'
#' @usage data(robo_care_raw)
#'
#'
#' @format A data frame with 337 rows and 61 labelled variables:
#' \describe{
#'   \item{age}{Age of the participant}
#'   \item{gender}{Gender of the participant}
#' }
#'
#' @references André Calero Valdez (Eds.) (2017) Akzeptanz autonomer Robotik, Apprimus Aachen
#' (\href{https://www.apprimus-verlag.de/akzeptanz-autonomer-robotik.html}{Apprimus})
#'
#' @source Data was self-collected at the RWTH Aachen University.
"robo_care_raw"



#' A data set to demonstrate the simpson paradox
#'
#'
#'
#' @format A data frame with 2000 rows and 3 variables:
#' \describe{
#'   \item{V1}{First Variable}
#'   \item{V2}{Second Variable}
#'   \item{group}{Grouping variable}
#' }
#'
#'
#' @source Data was generated.
#' @examples
#' library(ggplot2)
#' \donttest{ggplot(simpson_paradox ) + aes(x = V2, y = V1) +
#'        geom_point()}
"simpson_paradox"
