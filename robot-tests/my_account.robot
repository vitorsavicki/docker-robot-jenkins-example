*** Settings ***
Library  SeleniumLibrary


*** Test Cases ***
Login attempt with invalid user should show error

    Open Browser                http://demostore.supersqa.com/  Chrome
    Click Element               css=#site-navigation div:nth-of-type(1) ul.nav-menu li:nth-of-type(4) a
    Input Text                  id=username     fakeuser
    Input Text                  id=password     fakepassword
    Click Element               name=login
    Element Should Be Visible   css=#content > div > div.woocommerce > ul
    Element Text Should Be      css=#content > div > div.woocommerce > ul  ERROR: Invalid username. Lost your password?
    Close Browser
