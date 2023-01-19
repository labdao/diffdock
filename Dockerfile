FROM python:3.9.10

WORKDIR /app

## installing general dependencies
RUN pip install --upgrade pip 
RUN pip install pyg==0.7.1 --quiet
RUN pip install pyyaml==6.0 --quiet
RUN pip install scipy==1.7.3 --quiet
RUN pip install networkx==2.6.3 --quiet
RUN pip install biopython==1.79 --quiet
RUN pip install rdkit-pypi==2022.03.5 --quiet
RUN pip install e3nn==0.5.0 --quiet
RUN pip install spyrmsd==0.5.2 --quiet
RUN pip install pandas==1.3.5 --quiet
RUN pip install biopandas==0.4.1 --quiet
RUN pip install torch==1.12.1+cu113 --quiet

## installing torch
RUN pip install torch-scatter -f https://data.pyg.org/whl/torch-{torch.__version__}.html --quiet
RUN pip install torch-sparse -f https://data.pyg.org/whl/torch-{torch.__version__}.html --quiet
RUN pip install torch-cluster -f https://data.pyg.org/whl/torch-{torch.__version__}.html --quiet
RUN pip install git+https://github.com/pyg-team/pytorch_geometric.git  --quiet

## install esm
COPY . .
RUN git submodule init
RUN git submodule update
RUN pip install -e ./esm/.

#TODO #68 create proper test
ADD test.sh /
RUN chmod +x /test.sh