# Use a Python base image
FROM python:3

# Set the working directory
WORKDIR /app

# Install virtualenv
RUN pip install virtualenv

# Create a virtual environment in /venv
RUN virtualenv /venv

# Set environment variables to use the virtual environment
ENV PATH="/venv/bin:$PATH"

# Copy the requirements file into the container
COPY requirements.txt .

# Install dependencies within the virtual environment
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container
COPY . .

# Run database migrations
RUN python manage.py migrate

# Expose the port your app will run on
EXPOSE 8001

# Start the Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8001"]

