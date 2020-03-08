import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// yes, i know it's bad practice
GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class CDCFAQScreen extends StatelessWidget {

  final List<AnimatedFAQ> questions = [
    AnimatedFAQ(
      url: 'https://www.cdc.gov/coronavirus/types.html',
      question: 'What is a novel coronavirus?',
      answer: """A novel coronavirus is a new coronavirus that has not been previously identified. The virus causing coronavirus disease 2019 (COVID-19), is not the same as the coronaviruses that commonly circulate among humans and cause mild illness, like the common cold.

A diagnosis with coronavirus 229E, NL63, OC43, or HKU1 is not the same as a COVID-19 diagnosis. Patients with COVID-19 will be evaluated and cared for differently than patients with common coronavirus diagnosis.""",
    ),
    AnimatedFAQ(
      question: 'Why is the disease being called coronavirus disease 2019, COVID-19?',
      answer: """On February 11, 2020 the World Health Organization announced an official name for the disease that is causing the 2019 novel coronavirus outbreak, first identified in Wuhan China. The new name of this disease is coronavirus disease 2019, abbreviated as COVID-19. In COVID-19, ‘CO’ stands for ‘corona,’ ‘VI’ for ‘virus,’ and ‘D’ for disease. Formerly, this disease was referred to as “2019 novel coronavirus” or “2019-nCoV”.

There are many types of human coronaviruses including some that commonly cause mild upper-respiratory tract illnesses. COVID-19 is a new disease, caused be a novel (or new) coronavirus that has not previously been seen in humans. The name of this disease was selected following the World Health Organization (WHO) best practiceexternal icon for naming of new human infectious diseases.""",
    ),
    AnimatedFAQ(
      question: 'Why might someone blame or avoid individuals and groups (create stigma) because of COVID-19?',
      answer: """People in the U.S. may be worried or anxious about friends and relatives who are living in or visiting areas where COVID-19 is spreading. Some people are worried about the disease. Fear and anxiety can lead to social stigma, for example, towards Chinese or other Asian Americans or people who were in quarantine.

Stigma is discrimination against an identifiable group of people, a place, or a nation. Stigma is associated with a lack of knowledge about how COVID-19 spreads, a need to blame someone, fears about disease and death, and gossip that spreads rumors and myths.

Stigma hurts everyone by creating more fear or anger towards ordinary people instead of the disease that is causing the problem.""",
    ),
    AnimatedFAQ(
      question: 'How can people help stop stigma related to COVID-19?',
      answer: """People can fight stigma and help, not hurt, others by providing social support. Counter stigma by learning and sharing facts. Communicating the facts that viruses do not target specific racial or ethnic groups and how COVID-19 actually spreads can help stop stigma.""",
    ),
    AnimatedFAQ(
      question: 'What is the source of the virus?',
      answer: """Coronaviruses are a large family of viruses. Some cause illness in people, and others, such as canine and feline coronaviruses, only infect animals. Rarely, animal coronaviruses that infect animals have emerged to infect people and can spread between people. This is suspected to have occurred for the virus that causes COVID-19. Middle East Respiratory Syndrome (MERS) and Severe Acute Respiratory Syndrome (SARS) are two other examples of coronaviruses that originated from animals and then spread to people. More information about the source and spread of COVID-19 is available on the Situation Summary: Source and Spread of the Virus.""",
      url: 'https://www.cdc.gov/coronavirus/2019-nCoV/summary.html#anchor_1580079137454',
    ),
    AnimatedFAQ(
      question: 'How does the virus spread?',
      answer: """This virus was first detected in Wuhan City, Hubei Province, China. The first infections were linked to a live animal market, but the virus is now spreading from person-to-person. It’s important to note that person-to-person spread can happen on a continuum. Some viruses are highly contagious (like measles), while other viruses are less so.

The virus that causes COVID-19 seems to be spreading easily and sustainably in the community (“community spread”) in some affected geographic areas. Community spread means people have been infected with the virus in an area, including some who are not sure how or where they became infected.""",
    ),
    AnimatedFAQ(
      question: 'Can someone who has had COVID-19 spread the illness to others?',
      answer: """The virus that causes COVID-19 is spreading from person-to-person. Someone who is actively sick with COVID-19 can spread the illness to others. That is why CDC recommends that these patients be isolated either in the hospital or at home (depending on how sick they are) until they are better and no longer pose a risk of infecting others.

How long someone is actively sick can vary so the decision on when to release someone from isolation is made on a case-by-case basis in consultation with doctors, infection prevention and control experts, and public health officials and involves considering specifics of each situation including disease severity, illness signs and symptoms, and results of laboratory testing for that patient.

Current CDC guidance for when it is OK to release someone from isolation is made on a case by case basis and includes meeting all of the following requirements:

    - The patient is free from fever without the use of fever-reducing medications.
    - The patient is no longer showing symptoms, including cough.
    - The patient has tested negative on at least two consecutive respiratory specimens collected at least 24 hours apart.

Someone who has been released from isolation is not considered to pose a risk of infection to others.""",
    ),
    AnimatedFAQ(
      question: 'Can someone who has been quarantined for COVID-19 spread the illness to others?',
      answer: """Quarantine means separating a person or group of people who have been exposed to a contagious disease but have not developed illness (symptoms) from others who have not been exposed, in order to prevent the possible spread of that disease. Quarantine is usually established for the incubation period of the communicable disease, which is the span of time during which people have developed illness after exposure. For COVID-19, the period of quarantine is 14 days from the last date of exposure, because 14 days is the longest incubation period seen for similar coronaviruses. Someone who has been released from COVID-19 quarantine is not considered a risk for spreading the virus to others because they have not developed illness during the incubation period.""",
    ),
    AnimatedFAQ(
      question: 'Can the virus that causes COVID-19 be spread through food, including refrigerated or frozen food?',
      answer: """Coronaviruses are generally thought to be spread from person-to-person through respiratory droplets. Currently there is no evidence to support transmission of COVID-19 associated with food. Before preparing or eating food it is important to always wash your hands with soap and water for 20 seconds for general food safety. Throughout the day wash your hands after blowing your nose, coughing or sneezing, or going to the bathroom.

It may be possible that a person can get COVID-19 by touching a surface or object that has the virus on it and then touching their own mouth, nose, or possibly their eyes, but this is not thought to be the main way the virus spreads.

In general, because of poor survivability of these coronaviruses on surfaces, there is likely very low risk of spread from food products or packaging that are shipped over a period of days or weeks at ambient, refrigerated, or frozen temperatures.

Learn what is known about the spread of COVID-19.""",
      url: 'https://www.cdc.gov/coronavirus/2019-ncov/about/transmission.html',
    ),
    AnimatedFAQ(
      url: 'https://www.cdc.gov/coronavirus/2019-nCoV/summary.html#risk-assessment',
      question: 'Am I at risk for COVID-19 in the United States?',
      answer: """This is a rapidly evolving situation and the risk assessment may change daily. The latest updates are available on CDC’s Coronavirus Disease 2019 (COVID-19) website.""",
    ),
    AnimatedFAQ(
      question: 'Will warm weather stop the outbreak of COVID-19?',
      answer: """It is not yet known whether weather and temperature impact the spread of COVID-19. Some other viruses, like the common cold and flu, spread more during cold weather months but that does not mean it is impossible to become sick with these viruses during other months.  At this time, it is not known whether the spread of COVID-19 will decrease when weather becomes warmer.  There is much more to learn about the transmissibility, severity, and other features associated with COVID-19 and investigations are ongoing.""",
    ),
    AnimatedFAQ(
      question: 'What is community spread?',
      answer: """Community spread means people have been infected with the virus in an area, including some who are not sure how or where they became infected.""",
    ),
    AnimatedFAQ(
      question: 'Am I at risk for COVID-19 in the United States?',
      answer: """This is a rapidly evolving situation and the risk assessment may change daily. The latest updates are available on CDC’s Coronavirus Disease 2019 (COVID-19) website.""",
    ),
    AnimatedFAQ(
      question: 'Has anyone in the United States gotten infected?',
      answer: """Yes. There have been cases of COVID-19 in the U.S. related to travel and person-to-person spread. U.S. case counts are updated regularly on Mondays, Wednesday, and Fridays. See the current U.S. case count of COVID-19.""",
    ),
    AnimatedFAQ(
      question: 'How can I help protect myself?',
      answer: """Visit the COVID-19 Prevention and Treatment page to learn about how to protect yourself from respiratory illnesses, like COVID-19.""",
      url: 'https://www.cdc.gov/coronavirus/2019-ncov/about/prevention-treatment.html',
    ),
    AnimatedFAQ(
      question: 'What should I do if I had close contact with someone who has COVID-19?',
      answer: """There is information for people who have had close contact with a person confirmed to have, or being evaluated for, COVID-19 available online.""",
      url: 'https://www.cdc.gov/coronavirus/2019-ncov/guidance-prevent-spread.html#steps-for-close-contacts',
    ),
    AnimatedFAQ(
      question: 'Does CDC recommend the use of facemask to prevent COVID-19?',
      answer: """CDC does not recommend that people who are well wear a facemask to protect themselves from respiratory illnesses, including COVID-19. You should only wear a mask if a healthcare professional recommends it. A facemask should be used by people who have COVID-19 and are showing symptoms. This is to protect others from the risk of getting infected. The use of facemasks also is crucial for health workers and other people who are taking care of someone infected with COVID-19 in close settings (at home or in a health care facility).""",
    ),
    AnimatedFAQ(
      question: 'Am I at risk for COVID-19 from a package or products shipping from China?',
      answer: """There is still a lot that is unknown about the newly emerged COVID-19 and how it spreads. Two other coronaviruses have emerged previously to cause severe illness in people (MERS-CoV and SARS-CoV). The virus that causes COVID-19 is more genetically related to SARS-CoV than MERS-CoV, but both are betacoronaviruses with their origins in bats. While we don’t know for sure that this virus will behave the same way as SARS-CoV and MERS-CoV, we can use the information gained from both of these earlier coronaviruses to guide us. In general, because of poor survivability of these coronaviruses on surfaces, there is likely very low risk of spread from products or packaging that are shipped over a period of days or weeks at ambient temperatures. Coronaviruses are generally thought to be spread most often by respiratory droplets. Currently there is no evidence to support transmission of COVID-19 associated with imported goods and there have not been any cases of COVID-19 in the United States associated with imported goods. Information will be provided on the Coronavirus Disease 2019 (COVID-19) website as it becomes available.""",
      url: 'https://www.cdc.gov/coronavirus/2019-nCoV/index.html',
    ),
    AnimatedFAQ(
      question: 'What are the symptoms and complications that COVID-19 can cause?',
      answer: """Current symptoms reported for patients with COVID-19 have included mild to severe respiratory illness with fever, cough, and difficulty breathing. Read about COVID-19 Symptoms.""",
      url: 'https://www.cdc.gov/coronavirus/2019-ncov/about/symptoms.html',
    ),
    AnimatedFAQ(
      question: 'Should I be tested for COVID-19?',
      answer: """Call your healthcare professional if you feel sick with fever, cough, or difficulty breathing, and have been in close contact with a person known to have COVID-19, or if you live in or have recently traveled from an area with ongoing spread of COVID-19.

Your healthcare professional will work with your state’s public health department and CDC to determine if you need to be tested for COVID-19.""",
    ),
    AnimatedFAQ(
      question: 'How do you test a person for COVID-19?',
      answer: """State and local health departments who have identified a person under investigation (PUI) should immediately notify CDC’s Emergency Operations Center (EOC) to report the PUI and determine whether testing for COVID-19 at CDC is indicated. The EOC will assist local/state health departments to collect, store, and ship specimens appropriately to CDC, including during afterhours or on weekends/holidays.

For more information on specimen collection see CDC Information for Laboratories.""",
      url: 'https://www.cdc.gov/coronavirus/2019-nCoV/lab/index.html',
    ),
    AnimatedFAQ(
      question: 'Can a person test negative and later test positive for COVID-19?',
      answer: """Using the CDC-developed diagnostic test, a negative result means that the virus that causes COVID-19 was not found in the person’s sample. In the early stages of infection, it is possible the virus will not be detected.

For COVID-19, a negative test result for a sample collected while a person has symptoms likely means that the COVID-19 virus is not causing their current illness.""",
    ),
    AnimatedFAQ(
      question: 'What is CDC doing about COVID-19?',
      answer: """This is an emerging, rapidly evolving situation and CDC will continue to provide updated information as it becomes available. CDC works 24/7 to protect people’s health. More information about CDC’s response to COVID-19 is available online.""",
      url: 'https://www.cdc.gov/coronavirus/2019-nCoV/summary.html#cdc-response',
    )
];

  @override
  Widget build(BuildContext context) {
    
    List<Widget> children = List<Widget>();
    
    children.add(Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.black54),
          children: [
            TextSpan(
              text: 'the information on this page was taken directly from the FAQ page of the CDC website for coronavirus.\n'
            ),
            TextSpan(
              style: TextStyle(color: Colors.indigoAccent),
              text: 'https://www.cdc.gov/coronavirus/2019-ncov/faq.html\n',
              recognizer: TapGestureRecognizer()..onTap = () { launch('https://www.cdc.gov/coronavirus/2019-ncov/faq.html'); }
            ),
            TextSpan(
                text: 'the CDC is a reliable source of information and is part of the US government.\n'
            ),
          ]
        ),
      ),
    ));

    children.addAll(questions);
    
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('coronavirus CDC FAQ'),
        elevation: 0,
      ),
      body: ListView(
        children: children
      ),
    );
  }
}


class AnimatedFAQ extends StatefulWidget {

  final String question, answer, url;
  AnimatedFAQ({this.question, this.answer, this.url});

  @override
  _AnimatedFAQState createState() => _AnimatedFAQState();
}

class _AnimatedFAQState extends State<AnimatedFAQ> with TickerProviderStateMixin {

  bool expanded = false;
  AnimationController rotationController;
  final int ANIMATION_DURATION = 250;

  @override
  void initState() {
    rotationController = AnimationController(duration: Duration(milliseconds: ANIMATION_DURATION), vsync: this);
    super.initState();
  }

  void switchExpanded() {
    setState(() {
      expanded = !expanded;
    });
    if(!expanded) {
      rotationController.animateTo(0);
    } else {
      rotationController.animateTo(0.25);
    }
  }

  void urlLaunch(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Could not launch $url')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        child: InkWell(
          onTap: switchExpanded,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(widget.question, style: TextStyle(fontWeight: FontWeight.w700, color: Colors.indigo, fontSize: 18)),
                      flex: 19,
                    ),
                    Flexible(
                      child: AnimatedBuilder(
                        animation: Tween(begin: 0, end: 1).animate(rotationController),
                        child: Icon(Icons.chevron_right),
                        builder: (ctx, child) {
                          return Transform.rotate(angle: rotationController.value * 2*pi, child: child);
                        },
                      ),
                      flex: 1,
                    )
                  ],
                ),
                expanded ? Divider() : Container(),
                AnimatedSize(
                  vsync: this,
                  duration: Duration(milliseconds: ANIMATION_DURATION),
                  child: expanded ? Text(widget.answer, style: TextStyle(fontSize: 16)) : Container(),
                ),
                expanded && widget.url != null ? IconButton(
                  icon: Icon(Icons.open_in_new),
                  onPressed: () => urlLaunch(widget.url),
                ) : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
