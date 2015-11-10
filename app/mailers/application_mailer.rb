class ApplicationMailer < ActionMailer::Base
  default from: "noreply@workdey.com"
  layout "mailer"
  default to: ["olaide.ojewale@andela.com",
               "chinedu.daniel@andela.com",
               "amodu.temitope@andela.com",
               "ruth.chukwumam@andela.com",
               "workdeycomet@gmail.com"
              ]
end
