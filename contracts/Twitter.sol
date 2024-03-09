// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Twitter {
   
    uint16  Max_tweet_length=230;
    address public  owner;

     constructor(){
       owner=msg.sender;
     }

     modifier onlyOwner(){
      require(msg.sender==owner,"you arent authorized bro ");
      _;
     }

    function changeTweetLength(uint16 newTweetlength) public onlyOwner {
            Max_tweet_length=newTweetlength;
    }


   struct Tweet{
      uint256 id;
      address author;
      string content;
      uint256 timestamp;
      uint256  likes;

   }

    mapping (address => Tweet[] ) public tweets;

    event TweetCreated(uint256 id,address author,string content,uint256 timestamp);
    event TweetLiked(address liker,address tweetAuthor,uint256 tweetId,uint256 newtweetLikes);
    event TweetUnliked(address unliker,address tweetAuthor,uint256 tweetId,uint256 newtweetLikes);
     
 
  function createTweet(string memory _tweet) public {

      require(bytes(_tweet).length <= Max_tweet_length,"tweet is too long bro");

      Tweet memory newTweet=Tweet({
          id:tweets[msg.sender].length,
          author:msg.sender,
          content:_tweet,
          timestamp:block.timestamp,
          likes:0
      });

       tweets[msg.sender].push(newTweet);

       emit TweetCreated(newTweet.id, newTweet.author, newTweet.content, newTweet.timestamp);
  }
   
   function likeTweet(address author ,uint256 id) external {
        require(tweets[author][id].id==id,"TWEET DOESNT EXIST");
        tweets[author][id].likes++;
        emit TweetLiked(msg.sender, author, id,tweets[author][id].likes);
   }

   function unlikeTweet(address author ,uint256 id) external{
      require(tweets[author][id].id==id,"TWEET DOESNT EXIST");
      require(tweets[author][id].likes > 0,"THERE ARE NO TWEETS");
     tweets[author][id].likes--;

     emit TweetUnliked(msg.sender, author, id, tweets[author][id].likes);
  }


  function getTweet(uint _i) public view returns (Tweet memory){
          return  tweets[msg.sender][_i];
  }
 
  function getTweets(address _owner) public view returns (Tweet[] memory){
   return tweets[_owner];
  }
  
}
