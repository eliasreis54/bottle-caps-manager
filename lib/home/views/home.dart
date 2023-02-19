import 'package:bottle_caps_manager/home/cubit/home_cubit.dart';
import 'package:bottle_caps_manager/l10n/l10n.dart';
import 'package:bottle_caps_manager/team/generate_team/generate_team.dart';
import 'package:bottle_caps_manager/team/merge_team/merge_team.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nes_ui/nes_ui.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (_) => HomeCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
        if (state.index == 0) {
          return const GenerateTeamPage();
        } else {
          return const MergeTeamPage();
        }
      }),
      bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return BottomNavigationBar(
            onTap: (value) =>
                context.read<HomeCubit>().changeTabBarIndex(value),
            currentIndex: state.index,
            items: [
              BottomNavigationBarItem(
                label: l10n.generateTeam,
                icon: NesIcon(iconData: NesIcons.instance.check),
              ),
              BottomNavigationBarItem(
                label: l10n.mergeTeam,
                icon: NesIcon(iconData: NesIcons.instance.axe),
              ),
            ],
          );
        },
      ),
    );
  }
}
