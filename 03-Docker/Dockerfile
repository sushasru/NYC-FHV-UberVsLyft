FROM python:3.9.1
COPY requirements.txt .
RUN pip3 install -r requirements.txt --target "${LAMBDA_TASK_ROOT}"
RUN pip3 install numpy
COPY /02-Prefect/scripts /02-Prefect/scripts
WORKDIR "/02-Prefect/scripts"
RUN python3 -m venv prefect-env
RUN source prefect-env/bin/activate
RUN pip install -U prefect
RUN pip3 install requests
RUN pip3 install os
COPY app.py ${LAMBDA_TASK_ROOT}
COPY loaddatatoS3.py ${LAMBDA_TASK_ROOT}

#ENTRYPOINT ["python", "loaddatatoS3.py"]

