# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
LssspP2::Application.initialize!

ABILITIES = {'User'=>['read','create','update','approve'],
             'Topic'=>['read','create','update','active'],
             'PaymentGateway'=>['read','create','update','active'],
             'Certification' =>['read','create','update','active']
            }

