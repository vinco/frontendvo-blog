---
layout: post
title:  "Mobile First"
date:   2015-07-29 12:10:00
categories: design mobile
author: fermendozao
---


There are plenty of posts talking about *mobile first* for years, but let's just review the main points of this topic.

### Why mobile first?
So, basically mobile first tells us to design our applications and websites looking forward mobile devices as our priority. There are plenty of reasons, but lets just resume those on 3 main reasons

 - Growth
 - Restrictions
 - Capabilities

#### Growth
We could take some numbers and demonstrate you that mobile devices are all around, but you already know that, I mean, seriously, even your aunts have smartphones, and your little cousins have iPads at the age you used to have a stick and a rock.
The mobile market has grown ridiculously from the last years.


#### Restrictions
**Screen size**

The size of the screen on mobile devices has been the big concern for all the people involved on a website. The first thing that comes to our mind, is the fact that with less screen size, we might have to sacrifice some information. And yes, that's exactly right.
Think about all the stuff that is on your website, consider all navigation elements, irrelevant information, ads, secondary links, then you realize that a mobile first vision may be good to light your site.
Having a mobile first vision, let you design your website focusing on what your customers/visitors really need, it forces you to prioritize the information of your site.

**Performance**

Although in the last years mobile networks have been evolving, there's still a difference with the internet connection of your home.
Mobile networks can be very expensive on some areas and connections are still somehow slow.
Designing mobile first, forces you to use a lot of techniques and tools to save the data plans of your customers/visitors. You don't want them to stop visiting your site because it's slow, do you?

Some things you want to start doing or focus when developing an application/website, may include:

 - Use sprites
 - Concatenate and minify JS libraries and CSS.
 - Use CSS 3
 - Limit or remove JS libraries. Maybe you are just loading jQuery to make some tiny animation. Please don't.

Maybe you want to check this out: [http://youmightnotneedjquery.com/](http://youmightnotneedjquery.com/)

**Time and location**

> “[...] I like to imagine people as ‘one eyeball and one thumb`. One thumb because they are likely to be holding their mobile in one hand and using a single thumb to control it; one eyeball because in many locations where mobile devices are used we only have people’s partial attention”
> - Luke Wroblewski

[Luke Wroblewski](http://www.lukew.com/about/) wrote this amazing statement on his book [Mobile first](http://www.lukew.com/resources/mobile_first.asp)

Basically, this means that mobile users doesn't pay as much attention as a regular user. Time and location are some variables you have to struggle with.
So, maybe you have to start thinking new ways to get the attention of a mobile user. You have to be flexible, for the guy that visits your site while watching TV and for the one that makes a quick visit from the toilet.

### How to?
#### Content over navigation
Let's take the mobile site of Youtube as an example. The first thing that Youtube shows, is the content you may be interested with. It shows you video recommendations based on the videos you watched earlier. Thats what Youtube wants you to focus in.
Then they have the main and secondary navigation elements, but as you can see, those elements take the minimum space.

![Youtube](/images/mb-yt-content.png)  

>*Youtube put its content first and make the navigation very simple*  



Same thing with the Facebook site, a large percentage of the screen shows you the content of your news feed. The navigation icons and submenu take a small space of the screen.

![Facebook Content](/images/mb-fb-content.png)  

>*Facebook shows you first the content, the navigation icons take a secondary role*  



**Why is this important?**

Well, as we talked about it earlier, you want your users to focus on the things your website provide. Facebook and Youtube run by the content, they want you to click a lot of links so they can learn about you and then show you the right ads.
If you have a site that sells flight tickets, the first thing that you want your users see, maybe is the flight reservation form.

### Actions
Apple has a Human Interface Guideline. There they have some recommendations about the size of the buttons, for mobile devices, obviously.

[iOS Human Interface Guidelines](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/MobileHIG/)

But being just a little logical, we have to watch that the action buttons are good sized and good positioned so every user has easy access to them.

Let's take Youtube as an example again.
When you open a video, the main button is Play/Pause, which is the bigger part of the screen.
Then you have secondary button actions, from where you can like/dislike a video, add it to your favourites, share it, or flag it.
It's not a coincidence that those buttons are placed right there. Studies demonstrate that most of the people is right handed, and most of the people uses their smartphones scrolling with the right thumb.
So, take a look to the screenshot, the share button is very reachable.

![Youtube Video](/images/mb-yt-video.png)  

>*Action buttons are very reachable*

Obviously, Youtube knows that the regular user just watch videos, and they want them to share the content of their site.

### NUI
The Natural User Interface principles enable direct interactions with the content, and reduce all the elements that are no content at all.
Mobile devices allows that things like gestures modify the way we explore the web. For example, the pinch gesture that allows you to zoom in or out. With that kind of gestures, you are saving yourself a button or other GUI element that explicitly do that action.

Twitter has another good example, with the drag to refresh tweets gesture.

### Oh, the hover
It's almost obvious that the hover effect won't work equally on a mobile device. Hey! you no longer have a mouse.
Hover must be treated differently on mobile devices, since we are looking for a different experience.

Your options:

 - Have it on screen
 - Tap or swipe
 - Separate screen
 - Disappear

To choose an option, first you have to think if that thing that the hover does is really special.
If it is important, well,  maybe you have to make them static for the mobile experience and keep it on the screen.

Your other option is to show it on tap or swipe. That's a good one for actions or submenus that are important keeping them statics will mean a huge load of elements on first look.

If the content of the hover is too big, maybe the best idea is to keep it on a different page.

And lastly but not least, maybe you want to consider to disappear the content of the hover, you know, if its not very relevant.

## Conclusion
Mobile first is not new at all. I decided to write this post because in my professional life, I still see how designers forget the mobile experience or they take for granted that using Twitter Bootstrap or ZURB Foundation they  have a mobile site guaranteed.
Maybe its hard to move from designing for Desktop to designing for mobile, but its proven that there are more advantages adopting a mobile first vision.

If you want to learn more about this topic, I highly recommend you to read the book Luke Wroblewski wrote. This post is a resume I made by reading his book, its simply awesome how your design vision of a site changes after reading it.

You should also follow him on twitter ( [@lukew](https://twitter.com/lukew) ) he posts good tips about mobile interfaces and experiences.

