const projects = [
  {
    name: 'Project 1',
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    image: 'https://via.placeholder.com/400x300',
    url: 'https://example.com/project1'
  },
  {
    name: 'Project 2',
    description: 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    image: 'https://via.placeholder.com/400x300',
    url: 'https://example.com/project2'
  },
  // Add more projects here
];

export function get() {
  return {
    body: {
      projects
    }
  };
}
