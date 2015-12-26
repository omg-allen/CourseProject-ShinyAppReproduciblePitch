# Course Project: Shiny Application and Reproducible Pitch
# Author: Al Shain
setwd("~/Desktop/Coursera/DevelopingDataProducts/CourseProject-ShinyAppReproduciblePitch")

# This is the user-interface definition of the Framingham Risk Score Calculator.
# It calculates the Framingham Risk Score with updated scoring from WHO,
# new values include Race or Ethnicity plus prior family/self history of CVHD.
# The Framingham heart score is a a sex-specific algorithm used 
# to estimate the 10-year cardiovascular risk of an individual.
# 
#-------------------------------------------------------------------------------------------------
library(shiny)
library(png)
#-------------------------------------------------------------------------------------------------
shinyUI(
  fluidPage(theme = "bootstrap.css",
            
  pageWithSidebar(
    
    headerPanel('Framingham Risk Score Calculator with Race & Prior CVHD'),
    
    sidebarPanel(
      
      h4('Please select the following information:'),
      br(),
      h4('Information about you:'),
      radioButtons('SexRadioGroup', 'Gender:', 
                   choices = list(
                     'Male',
                     'Female'
                   ), selected = 'Female'),
      selectInput('RaceSelect','Ethnicity or Race:',
                  choices = list(
                    'Caucasian' = 1,
                    'Hispanic' = 2,
                    'Black' = 3,
                    'Asian' = 0 ), selected = 1),
      radioButtons('PriorRadioGroup', 'Have you ever told the doctor that you or a parent have had a prior heart attack or stroke?',
                  choices = list(
                    'Yes',
                    'No'), selected = 'No', T),
      selectInput('AgeSelect', 'Age:', 
                  choices = list(
                    '20–34 years' = 1,
                    '35–39 years' = 2,
                    '40–44 years' = 3,
                    '45–49 years' = 4,
                    '50–54 years' = 5,
                    '55–59 years' = 6,
                    '60–64 years' = 7,
                    '65–69 years' = 8,
                    '70–74 years' = 9,
                    '75–79 years' = 10
                  ), selected = 1),
       selectInput('SmokeSelect', 'Smoking status:',
                  choices = list(
                    'Smoker' = 1,
                    'Non-smoker' = 2
                  ), selected = 1),
      br(),
      h4('Clinical information about you:'),
      p('Your systolic blood pressure:'),
      radioButtons('SBPRadioGroup', 'Treated',
                   choices = list('Yes', 'No'), selected = 'Yes', T),
      selectInput('SBPSelect', 'Value, mm Hg',
                  choices = list(
                    'Under 120' = 1,
                    '120-129' = 2,
                    '130-139' = 3,
                    '140-159' = 4,
                    '160 or higher' = 5
                  ), selected = 2
      ),
      br(),
      h4('Lab results on your chloseterol levels:'),
      selectInput('TotCholSelect', 'Total cholesterol, mg/dL',
                  choices = list(
                    'Under 160' = 1,
                    '160-199' = 2,
                    '200-239' = 3,
                    '240-279' = 4,
                    '280 or higher' = 5
                  ), selected = 2),
      selectInput('HDLCholSelect', 'HDL cholesterol, mg/dL',
                  choices = list(
                    '60 or higher' = 1,
                    '50-59' = 2,
                    '40-49' = 3,
                    'Under 40' = 4
                  ), selected = 2),
      actionButton('RiskButton', 'Calculate risk')
    ), # sidebarPanel
    
    mainPanel(
      
      p('The predictors for cardiovascular heart disease was measured by a study, referred to as the Framingham Heart Study.'),
      p('The analysis of this study led to the development of the Framingham Risk Score, which represents your chances/risk'),
      p('of suffering from a cardiovascular event-disease within the next 10 years.'),
      p('In 2010 the World Health Orginization or WHO recommended adding more factors to the score, they included:'),
      p('Race or Ethnicity and'),
      p('Prior CVHD event where you either had a heart attack or stroke, or were informed by your physician that you'),
      p('or your parents suffered from CVHD.'),
      br(),
      p('The additional factors (referred to as WHOish) were added to the original algorithm used to estimate the 10-year'),
      p('cardiovascular risk of an individual or a score that reflects your chances of developing cardiovascular disease .'),
      p('The WHO variables increase the risk factor by adding to the score based upon your response.'),
      p('For some individuals with a low risk score is less than 20% CVHD risk at 10 years, with intermediate risk 20-30%,'),
      p('and with those with a high risk are above 30%.'),
      br(),
      h3('Your Framingham Heart Score and 10-year Risk:'),
      h4('Your Score is:'),
      textOutput('PointsOutput'),
      br(),
      h4('Your 10-year risk of CVHD is:'),
      textOutput('RiskOutput'),
      br(),
      h4('Graphs of expected Mortality rates as predicted by Framingham scores using WHO Ethnicity and Prior CVHD'),
      imageOutput("preImage"),
      br(),
      br()
      
    ) # mainPanel
    
  ) # pageWithSidebar
  )
) # shinyUI
#-------------------------------------------------------------------------------------------------