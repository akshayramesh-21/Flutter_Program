import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksynergy/controller/bloc/moviesData/movies_data_bloc.dart';
import 'package:geeksynergy/model/movies.dart'; // Adjust import as needed
import 'package:geeksynergy/controller/utlities/utlitis.dart'; // Adjust import as needed

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MoviesDataBloc>(context).add(MoviedataFetch());
  }

  void showCompanyInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Company Info'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Company: Geeksynergy Technologies Pvt Ltd'),
              SizedBox(height: 8),
              Text('Address: Sanjayanagar, Bengaluru-56'),
              SizedBox(height: 8),
              Text('Phone: XXXXXXXXX09'),
              SizedBox(height: 8),
              Text('Email: XXXXXX@gmail.com'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('geeksynergy Technologies Pvt Ltd'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'company_info') {
                showCompanyInfoDialog(context);
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'company_info',
                child: Text('Company Info'),
              ),
            ],
          ),
        ],
      ),
      body: BlocBuilder<MoviesDataBloc, MoviesDataState>(
        builder: (context, state) {
          if (state is MoviesDataLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MoviesDataLoaded) {
            return ListView.builder(
              itemCount: state.moviesdata.result.length,
              itemBuilder: (context, index) {
                final movie = state.moviesdata.result[index];

                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_drop_up,
                                size: 50,
                              ),
                              Text(
                                "1",
                                style: TextStyle(fontSize: 20),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                size: 50,
                              ),
                            ],
                          ),
                          SizedBox(width: 20),
                          Container(
                            width: 80,
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              image: DecorationImage(
                                image: NetworkImage(movie.poster ?? ''),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movie.title ?? '',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'genre: ${movie.genre ?? ''}',
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  'Director: ${movie.director ?? ''}',
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  'stars: ${movie.stars ?? ''}',
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  "Min | ${movie.language.toString()}| ${movie.releasedDate.toString()}",
                                  maxLines: 1,
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  "${movie.pageViews.toString()} views | Voted by ${movie.voted.toString()} people | ${movie.releasedDate.toString()}",
                                  maxLines: 1,
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: screenWidth * 0.9,
                          height: screenHeight * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.blue,
                          ),
                          child: Center(
                              child: Text("Watch Trailer", style: style1)),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is MoviesDataError) {
            return Center(child: Text('Failed to fetch movies'));
          }

          return Center(child: Text('Waiting for data...'));
        },
      ),
    );
  }
}
