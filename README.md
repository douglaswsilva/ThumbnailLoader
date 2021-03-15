# ThumbnailLoader
Load Thumbnail Module using a simpler version of the EssentialFeed module from EssentialDeveloper

## Architecture
![Screen Shot 2021-03-15 at 17 18 25](https://user-images.githubusercontent.com/15242786/111216942-c246eb80-85b3-11eb-8706-bdffcc438af5.png)

## Topics
✅ Creating MacOS Module for faster unit testing 
✅ Adding coverage and randomized tests
✅ Naming strategy: Given - When - Then
✅ TDD cycle
Test -> Fail -> Code -> Pass -> Refactor -> Commit
✅ Test for unintended completion block 
- Memory Leak Tests
- Add test line and file

## User Story - Load Thumbnails
As a user
I want to be able to see thumbnails
So I can know which images belong to a mission
 
### Use cases
✅ Offline/Online - Thumbnails are stored locally
Given I have local thumbnails
When I open the app
Then I see the stored thumbnails
 
Online - Thumbnails are not stored locally
Given I don't have local thumbnails
When I open the app
Then I download thumbnails from cloud  and see them

## Test Cases - Thumbnail Loader
✅ Local Loader
- ✅ Returns data successfully
- ✅ Returns error when media is not found 
- ✅ Does not deliver completion on deallocation
Remote Loader
- Returns media successfully
- Returns error when media is not found 
- Does not deliver completion on deallocation
Local With Remote Fallback Loader
- Return Local media when local is stored
- Returns cloud media when local fails
- Returns failure when not able to load local nor remote
- Does not complete on deallocation
