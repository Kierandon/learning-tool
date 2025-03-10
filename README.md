# Standards Learning Platform

A web application for learning industry standards through interactive courses, quizzes, and a gamified learning experience.

## 🚀 Features

- **Standards-Based Learning**: Explore and learn industry standards with structured content
- **Interactive Courses**: Progress through courses with informational steps and interactive questions
- **Question Types**: Multiple choice, true/false, matching, and ordering questions
- **Progress Tracking**: Track your learning progress through standards and courses
- **Gamification**: Earn coins, badges, and achievements as you learn
- **Daily Quests**: Complete daily challenges to earn bonus rewards
- **Certification**: Generate verifiable certificates upon completion of standards

## 📋 Prerequisites

- Ruby 3.4.2
- Rails 8.0

## 🛠️ Setup

### Clone the repository

```bash
git clone https://github.com/kierandon/learning-tool.git
cd learning-tool
```

### Install dependencies

```bash
bundle install
bun install
```

### Database setup

```bash
bin/rails db:create db:migrate
bin/rails db:seed
```

### Start the development server

```bash
bin/dev
```

The application will be available at http://localhost:3000

## 🏗️ Project Structure

### Key Directories

- `app/components`: View components organized by functionality (see Components section)
- `app/controllers`: Application controllers
- `app/models`: Data models
- `app/views`: View templates
- `app/services`: Service objects for business logic
- `app/javascript`: JavaScript modules and Stimulus controllers
- `db/seeds`: Seed data for development and testing


## 📊 Data Loaders

### Standard Loader

The application includes a standard loader service that imports standards from structured data files:

```bash
# Load a standard from a JSON or YAML file
bin/rails standards:import[path/to/standard.json]
```

Standard files should follow the defined schema with sections, subsections, and learning objectives.

### Course Loader

Courses can be imported using the course loader:

```bash
# Load a course from a JSON or YAML file
bin/rails courses:import[path/to/course.json]
```

Course files should include steps, questions, and their relationships to standards.

## 🎮 Gamification System

The application includes a gamification system with:

- Points/coins for correct answers
- Badges for completing courses
- Achievements for reaching milestones
- Daily quests for bonus rewards
- Streak tracking for consistent learning
