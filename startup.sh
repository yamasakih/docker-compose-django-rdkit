set -eu
sudo service postgresql start
# If other user can use Jupyter, you had better spesify unique token
# in order to avoid confrict of URL.
jupyter notebook --ip=0.0.0.0 --no-browser --NotebookApp.token=''
