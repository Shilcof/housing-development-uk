# Housing Development UK

Housing Development UK is a Sinatra web application to where housing developers can upload proposed developments for review by anyone.

For more information on some of the functionalities incorportated please view the blog post I wrote for the project at https://robert-shilcof.medium.com/getting-the-most-out-of-activerecord-a9ee8688b4dc, which also contains a demonstration video.

## Installation

To run Housing Development UK on your machine to view the functionalities first hand, you must first download the files from this repository, and change into the main directory in your terminal.

Then you must use bundler to install the required gems.

```bash
bundle install
```

Finally, you must create your own .env folder in this directory that contains:

```bash
SESSION_SECRET=your_secret_here
SALT=your_salt_here
```

These constants should be kept secret to you so that others cannot use them.

## Usage

To run the application on your computer you must host it with either:

```bash
rackup config.ru
```

if you want the application to be more responsive, or 

```bash
shotgun
```

which will be slower to respond than rack, but any changes made to the files will be reflected when viewing a new page.

To stop hosting the aplication, simply enter control + 'C' into the terminal where it is running.

From here you can create your own accounts and developments, and interact with the dummy data already present in the database.

## Contributing
Pull requests are welcome on [GitHub](https://github.com/Shilcof/superhero_battles). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the Contributor Covenant code of conduct.

## License
The application is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
