library(plumber)
library(tidyverse)
library(usethis)
source("auth_helper.R")
library(luxJob)

#* @apiTitle Basic luxJob API with Bearer token authentication
#* @apiDescription This is a simple API to demonstrate the use of luxJob
#* @apiVersion 1.0.0
#* @apiLicense MIT

#* Health check
#* @get /health
function() {
  list(status = "ok")
  }

#* Echo the parameter that was sent in
#* @param msg:string  The message to echo back.
#* @get /echo
function(
    res,
    req,
    msg="type your message here"
)
  {
  auth_helper(
    res,
    req,
    function() {
      list(msg = paste0("The message is: '", msg, "'"))
    }
  )
  }

#* Get books by id
#* @param book_id:int  The book id to be selected (1 to 1000)
#* @get /book_recommendations/<book_id>
#* @tag Books
function(
    res,
    req,
    book_id=5
    )
  {
  auth_helper(
    res,
    req,
    function() {
      get_book_by_id(as.integer(book_id))
      }
  )
  }

#* Get book recommendations
#* @param skill:str If selected, the skill that it will filter for. (e.g. communication)
#* @get /book_recommendations
#* @tag Books
function(
    res,
    req,
    skill=NULL
    )
  {
  auth_helper(
    res,
    req,
    function() {
      get_books(skill)
    }
  )
  }

#* Get company details
#* @param company_id:int  The company id to be selected.
#* @get /companies/<company_id>
#* @tag Companies
function(
    res,
    req,
    company_id=1
    )
  {
  auth_helper(
    res,
    req,
    function() {
      get_company_details(as.integer(company_id))
    }
  )
  }

#* Get companies
#* @param limit:int If selected, it limits the number of rows.
#* @get /companies
#* @tag Companies
function(
    res,
    req,
    limit=100
    )
  {
  auth_helper(
    res,
    req,
    function() {
      get_companies(as.integer(limit))
    }
  )
  }

#* Get specific learning track
#* @param track_id:int  The learning track id to be selected.
#* @get /learning_tracks/<track_id>
#* @tag Learning tracks
function(
    res,
    req,
    track_id
    )
  {
  auth_helper(
    res,
    req,
    function() {
      get_learning_track_by_id(as.integer(track_id))
    }
  )
}

#* Get learning tracks
#* @param skill_id:str If selected, it filters for the skill. (url) 
#* @get /learning_tracks
#* @tag Learning tracks
function(
    res,
    req,
    skill_id=NULL
    )
  {
  auth_helper(
    res,
    req,
    function() {
      get_learning_tracks(skill_id)
    }
  )
}

#* Get specific skill
#* @param skill_id:str* The skill id to be selected. (url)
#* @get /skills/<skill_id>
#* @tag Skills
function(
    res,
    req,
    skill_id
    )
  {
  auth_helper(
    res,
    req,
    function() {
      skill_id <- utils::URLdecode(skill_id)
      get_skill_by_id(as.character(skill_id))
    }
  )
}

#* Get skills
#* @param limit:int If selected, it limits the number of rows.
#* @param ordered:str* yes or no. To sort the results alphabetically.
#* @get /skills
#* @tag Skills
function(
    res,
    req,
    limit=100, ordered
    )
  {
  auth_helper(
    res,
    req,
    function() {
      limit <- as.integer(limit)
      get_skills(limit, ordered)
    }
  )
}

#* Get specific vacancy
#* @param vacancy_id:int  The vacancy id to be selected. (e.g. 917152540)
#* @get /selected_vacancy
#* @tag Vacancies
function(
    res,
    req,
    vacancy_id
    )
  {
  auth_helper(
    res,
    req,
    function() {
      vacancy_id <- as.integer(vacancy_id)
      get_vacancy_by_id(vacancy_id)
    }
  )
}

#* Get vacancies
#' @param occupation:str Optional filter for the occupation (job title).
#' @param company_id:int Optional filter for company_id.
#' @param canton:str Optional filter for canton in Luxembourg.
#' @param limit:int The maximum number of vacancies to return.
#* @get /vacancies
#* @tag Vacancies
function(
    res,
    req,
    occupation=NULL, company_id = NULL, canton = NULL, limit = 100
    )
  {
  auth_helper(
    res,
    req,
    function() {
      if (!is.null(company_id)) {company_id <- as.integer(company_id)}
      limit <- as.integer(limit)
      get_vacancies(occupation, company_id, canton, limit)
    }
  )
}

#* Get vacancies with skill
#' @param skill_id:str
#' @param company_id:int Optional filter for company_id.
#' @param canton:str Optional filter for canton in Luxembourg.
#' @param limit:int The maximum number of vacancies to return.
#* @get /vacancies_w_skill
#* @tag Vacancies
function(
    res,
    req,
    skill_id=NULL, company_id = NULL, canton = NULL, limit = 100
    )
  {
  auth_helper(
    res,
    req,
    function() {
      if (!is.null(company_id)) {company_id <- as.integer(company_id)}
      limit <- as.integer(limit)
      get_vacancies_with_skill(skill_id, company_id, canton, limit)
    }
  )
}

#* Log search
#* @param user_id:int User id to be inserted.
#* @param query:str* query to be posted in the search log 
#* @post /log_search
#* @tag Logs
function(
    res,
    req,
    user_id=NULL, query
    )
  {
  auth_helper(
    res,
    req,
    function() {
      if (!is.null(user_id)) {user_id <- as.integer(user_id)}
      log_search(user_id, query)
    }
  )
}