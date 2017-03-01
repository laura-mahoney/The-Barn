"""Short Flask server to illustrate ajax post from lots of buttons"""

from flask import Flask, request, render_template, jsonify
import jinja2

app = Flask(__name__)

# helper functions
# a = ['Allian,jessica', 'Elsa,meggie', 'Leilani,lavinia', 'Florence,rachel', 'Celia,leslie', 'Alice,heather', 'Meg,lavinia', 'Rebekkah,meggie', 'Kara,rachel', 'Kaylie,leslie', 'Malika,leslie', 'Kristin,rachel', 'Chelsea,rachel', 'Melissa,meggie', 'Vianey,rachel', 'Emily,jessica', 'Marisha,lavinia', 'Anli,lavinia', 'Dori,heather', 'Tiffany,heather', 'Janet,leslie', 'Patricia,heather', 'Terri,heather', 'Shai,jessica', 'Shijie,ally', 'Katie,lavinia', 'Annie,leslie', 'Megan,ally', 'Chandrika,leslie', 'Shalini,heather', 'Alitsiya,lavinia', 'Doria,jessica', 'Amy,cynthia', 'Alena,ally', 'Erin,meggie', 'Emma,ally']
    
def make_nodes_and_paths(filename):
    file_obj = open(filename)
    contents = file_obj.read()
    lines = contents.split('\n')

    nodes = {}
    for pair in lines:
        split = pair.split(',')
        if split:
            for person in split:
                person = person.strip()
                if not nodes.get(person):
                    nodes[person] = split[1].strip()
    
    nodes = [{'name':person, 'adviser': nodes[person]} for person in nodes.keys()]

    index_nodes = {}
    for idx, n in enumerate(nodes):
        index_nodes[n['name']] = (idx, n['adviser'])

    paths = []
    for line in lines:
        slt = line.split(',')
        if len(slt) == 2:
            source, target = slt
            paths.append({'source': index_nodes[source][0], 'target': index_nodes[target][0]  })

    return nodes, paths


@app.route("/")
def index():
    """Return homepage."""
    return render_template("homepage.html")


@app.route('/advanced')
def index_advanced():
    """Return homepage."""
    return render_template("homepage_advanced.html")


@app.route("/data.json")
def get_graph_data():
    # call helper functions
    nodes, paths = make_nodes_and_paths('f16a.csv')
    return jsonify({'nodes':nodes, 'paths':paths})


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0")
