import sys
def handler(event,context):
    return 'Hello from AWS lambda using Python '+sys.version + '!'