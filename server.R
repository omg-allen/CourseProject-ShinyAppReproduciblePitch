# Course Project: Shiny Application and Reproducible Pitch
# Author: Al Shain
# setwd("~/Desktop/Coursera/DevelopingDataProducts/CourseProject-ShinyAppReproduciblePitch")
# This is the server logic for the Framingham Risk Score Calculator plus ethnicity and prior CVHD.
# It calculates the Framingham Risk Score with updated scoring from WHO,
# new values include Race or Ethnicity plus prior family/self history of CVHD.
# The Framingham heart score is a a sex-specific algorithm used 
# to estimate the 10-year cardiovascular risk of an individual.
# 
#-------------------------------------------------------------------------------------------------
library(shiny)
#-------------------------------------------------------------------------------------------------
# Functions:
# Calculate the Framingham score for Men
points.men <- function(age, race, prior, totchol, smoker, HDLChol, treated, SBP)
{
  points = 0
 
  # Age points
  if(age == 1) points = points - 9
  else if(age == 2) points = points - 4
  else if(age == 4) points = points + 3
  else if(age == 5) points = points + 6
  else if(age == 6) points = points + 8
  else if(age == 7) points = points + 10
  else if(age == 8) points = points + 11
  else if(age == 9) points = points + 12
  else if(age == 10) points = points + 13

  # Race or Ethnicity score
  if(race == 0 ) points = points - 1
   else if(race == 2) points = points + 2
   else if(race == 3) points = points + 3
  
  # Prior family CVHD flag
  if(prior == 'Yes')
  {
    if(age == 1 | age == 2) points = points + 3
    else if(age == 3 | age == 4) points = points + 2
    else if(age == 5 | age == 6) points = points + 1
    else if(age == 7 | age == 8) points = points + 1
    else if(age == 9 | age == 10) points = points + 1
  }
  
  # Total cholesterol points by age
  if(age == 1 | age == 2)
  {
    # Age 20–39 years
    if(totchol == 2) points = points + 4
    else if(totchol == 3) points = points + 7
    else if(totchol == 4) points = points + 9
    else if(totchol == 5) points = points + 11
  } else if(age == 3 | age == 4)
  {
    # Age 40–49 years
    if(totchol == 2) points = points + 3
    else if(totchol == 3) points = points + 5
    else if(totchol == 4) points = points + 6
    else if(totchol == 5) points = points + 8
  } else if(age == 5 | age == 6)
  {
    # Age 50–59 years
    if(totchol == 2) points = points + 2
    else if(totchol == 3) points = points + 3
    else if(totchol == 4) points = points + 4
    else if(totchol == 5) points = points + 5
  } else if(age == 7 | age == 8)
  {
    # Age 60–69 years
    if(totchol == 2) points = points + 1
    else if(totchol == 3) points = points + 1
    else if(totchol == 4) points = points + 2
    else if(totchol == 5) points = points + 3
  } else if(age == 9 | age == 10)
  {
    # Age 70–79 years
    if(totchol == 4) points = points + 1
    else if(totchol == 5) points = points + 1
  } 
  
  # Cigarette smoker points by age
  if(smoker == 1)
  {
    if(age == 1 | age == 2) points = points + 8
    else if(age == 3 | age == 4) points = points + 5
    else if(age == 5 | age == 6) points = points + 3
    else if(age == 7 | age == 8) points = points + 1
    else if(age == 9 | age == 10) points = points + 1
  }
  
  # HDL cholesterol points
  if(HDLChol == 1) points = points - 1
  else if(HDLChol == 3) points = points + 1
  else if(HDLChol == 4) points = points + 2
  
  # Systolic blood pressure points
  if(treated == 'Yes')
  {
    if(SBP == 2) points = points + 1
    else if(SBP == 3) points = points + 2
    else if(SBP == 4) points = points + 2
    else if(SBP == 5) points = points + 3
  } else if(treated == 'No')
  {
    if(SBP == 3) points = points + 1
    else if(SBP == 4) points = points + 1
    else if(SBP == 5) points = points + 2
  }
  
  return(points)
}

# Calculate the Framingham score for Women
points.women <- function(age, race, prior, totchol, smoker, HDLChol, treated, SBP)
{
  points = 0

  # Age points
  if(age == 1) points = points - 7
  else if(age == 2) points = points - 3
  else if(age == 4) points = points + 3
  else if(age == 5) points = points + 6
  else if(age == 6) points = points + 8
  else if(age == 7) points = points + 10
  else if(age == 8) points = points + 12
  else if(age == 9) points = points + 14
  else if(age == 10) points = points + 16
  
  # Race or Ethnicity score
  if(race == 0 ) points = points - 1
  else if(race == 2) points = points + 2
  else if(race == 3) points = points + 3
  
  # Prior family CVHD flag
  if(prior == 'Yes')
  {
    if(age == 1 | age == 2) points = points + 3
    else if(age == 3 | age == 4) points = points + 2
    else if(age == 5 | age == 6) points = points + 1
    else if(age == 7 | age == 8) points = points + 1
    else if(age == 9 | age == 10) points = points + 1
  }

  # Total cholesterol points by age
  if(age == 1 | age == 2)
  {
    # Age 20–39 years
    if(totchol == 2) points = points + 4
    else if(totchol == 3) points = points + 8
    else if(totchol == 4) points = points + 11
    else if(totchol == 5) points = points + 13
  } else if(age == 3 | age == 4)
  {
    # Age 40–49 years
    if(totchol == 2) points = points + 3
    else if(totchol == 3) points = points + 6
    else if(totchol == 4) points = points + 8
    else if(totchol == 5) points = points + 10
  } else if(age == 5 | age == 6)
  {
    # Age 50–59 years
    if(totchol == 2) points = points + 2
    else if(totchol == 3) points = points + 4
    else if(totchol == 4) points = points + 5
    else if(totchol == 5) points = points + 7
  } else if(age == 7 | age == 8)
  {
    # Age 60–69 years
    if(totchol == 2) points = points + 1
    else if(totchol == 3) points = points + 2
    else if(totchol == 4) points = points + 3
    else if(totchol == 5) points = points + 4
  } else if(age == 9 | age == 10)
  {
    # Age 70–79 years
    if(totchol == 2) points = points + 1
    else if(totchol == 3) points = points + 1
    else if(totchol == 4) points = points + 2
    else if(totchol == 5) points = points + 2
  } 
  
  # Cigarette smoker points by age
  if(smoker == 1)
  {
    if(age == 1 | age == 2) points = points + 9
    else if(age == 3 | age == 4) points = points + 7
    else if(age == 5 | age == 6) points = points + 4
    else if(age == 7 | age == 8) points = points + 2
    else if(age == 9 | age == 10) points = points + 1
  }
  
  # HDL cholesterol points
  if(HDLChol == 1) points = points - 1
  else if(HDLChol == 3) points = points + 1
  else if(HDLChol == 4) points = points + 2
  
  # Systolic blood pressure points
  if(treated == 'Yes')
  {
    if(SBP == 2) points = points + 3
    else if(SBP == 3) points = points + 4
    else if(SBP == 4) points = points + 5
    else if(SBP == 5) points = points + 6
  } else if(treated == 'No')
  {
    if(SBP == 2) points = points + 1
    else if(SBP == 3) points = points + 2
    else if(SBP == 4) points = points + 3
    else if(SBP == 5) points = points + 4
  }
  
  return(points)
}
#-------------------------------------------------------------------------------------------------
shinyServer(
  
  function(input, output) 
  {
    race <- reactive({as.numeric(input$RaceSelect)})
    prior <- reactive({as.character(input$PriorRadioGroup)})
    age <- reactive({as.numeric(input$AgeSelect)})
    totchol <- reactive({as.numeric(input$TotCholSelect)})
    smoker <- reactive({as.numeric(input$SmokeSelect)})
    treated <- reactive({as.character(input$SBPRadioGroup)})
    SBP <- reactive({as.numeric(input$SBPSelect)})
    HDLChol <- reactive({as.numeric(input$HDLCholSelect)})
    sex <- reactive({as.character(input$SexRadioGroup)})
    
    output$PointsOutput <- renderText({
      if(input$RiskButton > 0)
      {
        if(sex() == 'Male')
        {
          points.men(age(), race(), prior(), totchol(), smoker(), HDLChol(), treated(), SBP())
        }
        else if(sex() == 'Female')
        {   
          points.women(age(), race(), prior(), totchol(), smoker(), HDLChol(), treated(), SBP())
        }
      }
    })
    
    output$RiskOutput <- renderText({
      if(input$RiskButton > 0)
      {
        risk <- NULL
        
        if(sex() == 'Male')
        {
          risk <- points.men(age(), race(), prior(), totchol(), smoker(), HDLChol(), treated(), SBP())
        }
        else if(sex() == 'Female')
        {
          risk <- points.women(age(), race(), prior(), totchol(), smoker(), HDLChol(), treated(), SBP())
        }
        
        if(risk == 0) print('< 1%', quote = F)
        else if(risk >= 1 & risk <= 4) print('1%', quote = F)
        else if(risk >= 5 & risk <= 6) print('2%', quote = F)
        else if(risk == 7) print('3%', quote = F)
        else if(risk == 8) print('4%', quote = F)
        else if(risk == 9) print('5%', quote = F)
        else if(risk == 10) print('6%', quote = F)
        else if(risk == 11) print('8%', quote = F)
        else if(risk == 12) print('10%', quote = F)
        else if(risk == 13) print('12%', quote = F)
        else if(risk == 14) print('16%', quote = F)
        else if(risk == 15) print('20%', quote = F)
        else if(risk == 16) print('25%', quote = F)
        else if(risk == 17) print('30%', quote = F)
        else if(risk == 18) print('35%', quote = F)
        else if(risk == 19) print('40%', quote = F)
        else if(risk >= 18) print('Go to the hospital NOW! YOUR RISK IS ABOVE 50%', quote = F)
      }
    })
    
    output$preImage <- renderImage({
      filename <- './images/Framingham-WhoGraphs.jpg'
       list(src = filename)}, deleteFile = FALSE) 
  }
)
#-------------------------------------------------------------------------------------------------