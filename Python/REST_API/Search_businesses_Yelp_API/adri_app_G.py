from flask import Flask, jsonify, request, render_template
import requests

app = Flask(__name__)


@app.route('/')
def hello():
        return 'Welcome! Here you can search business in Yelp.'
      
@app.route('/translation-san-francisco')
def translation_agencies():
    endpoint = 'https://api.yelp.com/v3/businesses/search'
    token_yelp = '' #insert your personal token provided by Yelp
    headers = {"Authorization": "Bearer {}".format(token_yelp)}
    params = {'location': 'CA',
            'term':'translation'
          }

    response = requests.get(endpoint, headers = headers, params = params)
    final_message = {'status': 200, 'message': 'Successful request', 'data': response.json()['businesses']}
    return jsonify(final_message)
  
@app.route('/personalized-search', methods=['POST','GET'])
def personalizedSearch():
    response = {}
    location = request.args.get('location')
    term = request.args.get('term')
                    
    try:
        endpoint = 'https://api.yelp.com/v3/businesses/search'
        token_yelp = '' #insert your personal token provided by Yelp
        headers = {"Authorization": "Bearer {}".format(token_yelp)}
        params = {'location': location,
                'term': term
                }
        data = requests.get(endpoint, headers = headers, params = params)
        response = {'status': 200, 'message': 'Successful request', 'data': data.json()['businesses']}
    except:
        response = {'status': 400, 'message': 'Please use words instead of numbers for your search'}
    return jsonify(response)
        
          
      
app.run(debug=True,host='localhost', port=5000)